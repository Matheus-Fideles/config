-- Java, Spring Boot, Quarkus configuration
return {
  -- Mason tools for Java
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jdtls", -- Java LSP (Eclipse JDT Language Server)
        "java-debug-adapter", -- Java debugger
        "java-test", -- Java test runner
        "google-java-format", -- Java formatter
        "checkstyle", -- Java linter
      })
    end,
  },

  -- JDTLS - Java Development Tools Language Server
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    ft = { "java" },
    opts = function()
      local mason_registry = require("mason-registry")
      local lombok_jar = ""

      -- Verificar se jdtls está instalado antes de obter o caminho
      if mason_registry.is_installed("jdtls") then
        local ok, jdtls_pkg = pcall(mason_registry.get_package, mason_registry, "jdtls")
        if ok and jdtls_pkg then
          lombok_jar = jdtls_pkg:get_install_path() .. "/lombok.jar"
        end
      end

      return {
        root_dir = require("lspconfig.util").root_pattern(
          "build.gradle",
          "build.gradle.kts",
          "settings.gradle",
          "settings.gradle.kts",
          "pom.xml",
          ".git"
        ),
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,
        cmd = function()
          local cmd = { "jdtls" }
          -- Adicionar Lombok support apenas se o jar existir
          if lombok_jar ~= "" then
            table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok_jar)
          end
          return cmd
        end,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = type(opts.cmd) == "function" and opts.cmd() or vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,
        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
                "io.quarkus.test.junit.QuarkusTest",
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
              importOrder = {
                "java",
                "javax",
                "jakarta",
                "org",
                "com",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
            configuration = {
              -- Configure Java runtimes
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = vim.fn.expand("~/.sdkman/candidates/java/17.0.14-jbr"),
                },
                {
                  name = "JavaSE-21",
                  path = vim.fn.expand("~/.sdkman/candidates/java/21-tem"),
                  default = true,
                },
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- Find the extra bundles for debugging and testing
      local mason_registry = require("mason-registry")
      local bundles = {}

      -- Java Debug Adapter
      if mason_registry.is_installed("java-debug-adapter") then
        local ok, java_dbg_pkg = pcall(mason_registry.get_package, mason_registry, "java-debug-adapter")
        if ok and java_dbg_pkg then
          local java_dbg_path = java_dbg_pkg:get_install_path()
          local jar_patterns = {
            java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
          }
          for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
              table.insert(bundles, bundle)
            end
          end
        end
      end

      -- Java Test
      if mason_registry.is_installed("java-test") then
        local ok, java_test_pkg = pcall(mason_registry.get_package, mason_registry, "java-test")
        if ok and java_test_pkg then
          local java_test_path = java_test_pkg:get_install_path()
          for _, bundle in ipairs(vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

      local function attach_jdtls()
        local fname = vim.api.nvim_buf_get_name(0)

        local config = {
          cmd = opts.full_cmd(opts),
          root_dir = opts.root_dir(fname),
          init_options = {
            bundles = bundles,
          },
          settings = opts.settings,
          capabilities = require("blink.cmp").get_lsp_capabilities(),
        }

        require("jdtls").start_or_attach(config)
      end

      -- Attach to existing buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = attach_jdtls,
      })

      -- Setup DAP after jdtls attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            if opts.dap and mason_registry.is_installed("java-debug-adapter") then
              require("jdtls").setup_dap(opts.dap)
              require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
            end

            -- Java specific keymaps
            vim.keymap.set("n", "<leader>Jo", function()
              require("jdtls").organize_imports()
            end, { buffer = args.buf, desc = "Organize Imports" })

            vim.keymap.set("n", "<leader>Jv", function()
              require("jdtls").extract_variable()
            end, { buffer = args.buf, desc = "Extract Variable" })

            vim.keymap.set("v", "<leader>Jv", function()
              require("jdtls").extract_variable({ visual = true })
            end, { buffer = args.buf, desc = "Extract Variable" })

            vim.keymap.set("n", "<leader>Jc", function()
              require("jdtls").extract_constant()
            end, { buffer = args.buf, desc = "Extract Constant" })

            vim.keymap.set("v", "<leader>Jc", function()
              require("jdtls").extract_constant({ visual = true })
            end, { buffer = args.buf, desc = "Extract Constant" })

            vim.keymap.set("v", "<leader>Jm", function()
              require("jdtls").extract_method({ visual = true })
            end, { buffer = args.buf, desc = "Extract Method" })

            vim.keymap.set("n", "<leader>Jt", function()
              require("jdtls").test_nearest_method()
            end, { buffer = args.buf, desc = "Test Nearest Method" })

            vim.keymap.set("n", "<leader>JT", function()
              require("jdtls").test_class()
            end, { buffer = args.buf, desc = "Test Class" })
          end
        end,
      })

      -- Attach to current buffer if it's Java
      if vim.bo.filetype == "java" then
        attach_jdtls()
      end
    end,
  },

  -- Treesitter for Java
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "java",
        "kotlin", -- Often used alongside Java
        "groovy", -- For Gradle build files
        "xml", -- For pom.xml and configs
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
    },
  },

  -- Which-key group for Java
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>J", group = "Java", icon = "" },
      },
    },
  },
}
