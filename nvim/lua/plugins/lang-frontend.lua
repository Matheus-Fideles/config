-- Frontend: React, Vue, Angular configuration
-- Note: TypeScript/JavaScript base is already in lazy.lua extras
return {
  -- Mason tools for Frontend
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Vue
        "vue-language-server",
        -- Angular
        "angular-language-server",
        -- Emmet
        "emmet-language-server",
        -- CSS/SCSS
        "cssmodules-language-server",
        "stylelint",
      })
    end,
  },

  -- LSP for Vue
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Vue 3 with Volar
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },
        -- Angular
        angularls = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
          end,
        },
        -- Emmet for fast HTML/JSX writing
        emmet_language_server = {
          filetypes = {
            "html",
            "css",
            "scss",
            "less",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "svelte",
          },
        },
        -- CSS Modules
        cssmodules_ls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
      },
    },
  },

  -- Treesitter for frontend
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "javascript",
        "typescript",
        "vue",
        "angular",
        "html",
        "css",
        "scss",
        "jsdoc",
        "styled", -- styled-components
      })
    end,
  },

  -- Auto close and rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      per_filetype = {
        ["html"] = { enable_close = true },
        ["vue"] = { enable_close = true },
        ["typescriptreact"] = { enable_close = true },
        ["javascriptreact"] = { enable_close = true },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        vue = { "prettier" },
        angular = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        vue = { "eslint" },
        scss = { "stylelint" },
        css = { "stylelint" },
      },
    },
  },

  -- SchemaStore for package.json and tsconfig
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },

  -- NPM package info
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "json" },
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
    },
    keys = {
      {
        "<leader>cps",
        function()
          require("package-info").show()
        end,
        desc = "Show Package Info",
      },
      {
        "<leader>cph",
        function()
          require("package-info").hide()
        end,
        desc = "Hide Package Info",
      },
      {
        "<leader>cpu",
        function()
          require("package-info").update()
        end,
        desc = "Update Package",
      },
      {
        "<leader>cpd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete Package",
      },
      {
        "<leader>cpi",
        function()
          require("package-info").install()
        end,
        desc = "Install Package",
      },
      {
        "<leader>cpv",
        function()
          require("package-info").change_version()
        end,
        desc = "Change Package Version",
      },
    },
  },
}
