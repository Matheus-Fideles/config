-- Node.js: Express, Next.js, Fastify configuration
-- TypeScript base is already configured in lazy.lua extras
return {
  -- Mason tools for Node.js
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "js-debug-adapter", -- JavaScript/Node debugger
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "json5",
        "jsonc",
      })
    end,
  },

  -- DAP for Node.js debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      local mason_registry = require("mason-registry")

      -- JavaScript/Node adapter configuration
      if not dap.adapters["pwa-node"] and mason_registry.is_installed("js-debug-adapter") then
        local ok, js_debug_pkg = pcall(mason_registry.get_package, mason_registry, "js-debug-adapter")
        if ok and js_debug_pkg then
          local js_debug_path = js_debug_pkg:get_install_path()
          dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = "node",
              args = {
                js_debug_path .. "/js-debug/src/dapDebugServer.js",
                "${port}",
              },
            },
          }
        end
      end

      -- Node.js configurations
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            -- Launch current file
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            -- Attach to running process
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to process",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
            -- Next.js server-side debugging
            {
              type = "pwa-node",
              request = "launch",
              name = "Next.js: debug server-side",
              runtimeExecutable = "npm",
              runtimeArgs = { "run", "dev" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              skipFiles = { "<node_internals>/**", "node_modules/**" },
            },
            -- Express/Fastify server debugging
            {
              type = "pwa-node",
              request = "launch",
              name = "Node: Launch Server",
              runtimeExecutable = "npm",
              runtimeArgs = { "run", "start" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              skipFiles = { "<node_internals>/**", "node_modules/**" },
            },
            -- Debug npm scripts
            {
              type = "pwa-node",
              request = "launch",
              name = "Node: Debug npm script",
              runtimeExecutable = "npm",
              runtimeArgs = function()
                local script = vim.fn.input("Script name: ", "start")
                return { "run", script }
              end,
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
            },
            -- Jest testing
            {
              type = "pwa-node",
              request = "launch",
              name = "Jest: Debug Tests",
              runtimeExecutable = "node",
              runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
              },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
            },
          }
        end
      end
    end,
  },

  -- neotest for Node.js testing (Jest, Vitest)
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        ["neotest-vitest"] = {},
      },
    },
  },

  -- REST client for API development (Express, Fastify, Next.js API routes)
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "http" },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run HTTP Request" },
      { "<leader>rl", "<cmd>Rest run last<cr>", desc = "Run Last HTTP Request" },
    },
    opts = {
      result = {
        split = {
          horizontal = false,
          in_place = false,
        },
        behavior = {
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
      },
    },
  },

  -- Environment variables support
  {
    "laytan/cloak.nvim",
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = { ".env*", "*.env" },
          cloak_pattern = "=.+",
          replace = nil,
        },
      },
    },
    keys = {
      { "<leader>ct", "<cmd>CloakToggle<cr>", desc = "Toggle Cloak (hide secrets)" },
    },
  },
}
