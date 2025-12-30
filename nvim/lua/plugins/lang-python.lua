-- Python, PySpark, Flask configuration
return {
  -- Mason tools for Python
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright", -- Python LSP
        "ruff", -- Python linter/formatter (fast, replaces flake8, black, isort)
        "black", -- Python formatter
        "isort", -- Import sorter
        "debugpy", -- Python debugger
        "mypy", -- Static type checker
      })
    end,
  },

  -- LSP configuration for Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Pyright - Principal LSP para Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- off, basic, strict
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                -- PySpark stubs
                stubPath = vim.fn.stdpath("data") .. "/stubs",
                extraPaths = {
                  -- Add your PySpark path if needed
                  -- "/opt/spark/python",
                  -- "/opt/spark/python/lib/py4j-0.10.9.7-src.zip",
                },
              },
            },
          },
        },
        -- Ruff LSP - Linting e formatting rápido
        ruff = {
          init_options = {
            settings = {
              -- Ruff settings
              lineLength = 88,
              indent = 4,
              -- Enable specific rule sets
              select = {
                "E", -- pycodestyle errors
                "F", -- pyflakes
                "I", -- isort
                "N", -- pep8-naming
                "W", -- pycodestyle warnings
                "UP", -- pyupgrade
                "B", -- flake8-bugbear
                "C4", -- flake8-comprehensions
                "SIM", -- flake8-simplify
              },
            },
          },
        },
      },
    },
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" }, -- Use ruff for formatting
      },
    },
  },

  -- Linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff", "mypy" },
      },
    },
  },

  -- Treesitter for Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "rst", -- reStructuredText for docstrings
        "ninja", -- Build system
        "toml", -- pyproject.toml
      })
    end,
  },

  -- neotest for Python testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = ".venv/bin/python",
          args = { "-vv", "--tb=short" },
        },
      },
    },
  },

  -- DAP for Python debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      keys = {
        {
          "<leader>dPt",
          function()
            require("dap-python").test_method()
          end,
          desc = "Debug Method (Python)",
        },
        {
          "<leader>dPc",
          function()
            require("dap-python").test_class()
          end,
          desc = "Debug Class (Python)",
        },
      },
      config = function()
        local mason_registry = require("mason-registry")

        -- Verificar se debugpy está instalado antes de configurar
        if mason_registry.is_installed("debugpy") then
          local ok, debugpy_pkg = pcall(mason_registry.get_package, mason_registry, "debugpy")
          if ok and debugpy_pkg then
            local path = debugpy_pkg:get_install_path()
            require("dap-python").setup(path .. "/venv/bin/python")
          end
        end
      end,
    },
  },

  -- venv selector for Python virtual environments
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
      auto_refresh = true,
    },
    cmd = "VenvSelect",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
    },
  },
}
