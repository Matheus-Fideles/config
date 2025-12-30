-- Mobile: Flutter, React Native, Swift configuration
return {
  -- Mason tools for Mobile development
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Dart/Flutter
        "dart-debug-adapter",
        -- Swift (via sourcekit-lsp - usually comes with Xcode)
      })
    end,
  },

  -- Flutter/Dart support
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    ft = { "dart" },
    opts = {
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    },
    keys = {
      { "<leader>Fs", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>Fr", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Hot Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>Fl", "<cmd>FlutterLogToggle<cr>", desc = "Flutter Log Toggle" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
      { "<leader>Ft", "<cmd>FlutterDevTools<cr>", desc = "Flutter DevTools" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
    },
  },

  -- Treesitter for Mobile languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "dart",
        "swift",
      })
    end,
  },

  -- LSP for Swift (requires sourcekit-lsp from Xcode)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Swift - sourcekit-lsp (comes with Xcode)
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift", "objective-c", "objective-cpp" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Package.swift",
              "compile_commands.json",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
        },
      },
    },
  },

  -- Which-key groups
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>F", group = "Flutter", icon = "" },
      },
    },
  },

  -- React Native specific configurations
  -- Note: React Native uses the same TypeScript/JavaScript LSP
  -- but we can add specific configurations
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Add React Native specific settings to tsserver
      if opts.servers and opts.servers.tsserver then
        opts.servers.tsserver.settings = opts.servers.tsserver.settings or {}
        opts.servers.tsserver.settings.typescript = opts.servers.tsserver.settings.typescript or {}
        opts.servers.tsserver.settings.typescript.preferences = {
          importModuleSpecifier = "relative",
        }
      end
    end,
  },

}
