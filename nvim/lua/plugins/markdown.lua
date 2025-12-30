-- Markdown support with live preview
return {
  -- Markdown Preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- Auto-open preview when entering markdown file
      vim.g.mkdp_auto_start = 0
      -- Auto-close preview when leaving markdown buffer
      vim.g.mkdp_auto_close = 1
      -- Refresh on save or leaving insert mode
      vim.g.mkdp_refresh_slow = 0
      -- Open preview in same window
      vim.g.mkdp_open_to_the_world = 0
      -- Custom IP for preview
      vim.g.mkdp_open_ip = ""
      -- Browser to use
      vim.g.mkdp_browser = ""
      -- Echo preview URL
      vim.g.mkdp_echo_preview_url = 1
      -- Custom function for browser
      vim.g.mkdp_browserfunc = ""
      -- Preview options
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
      -- Custom CSS for preview
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      -- Port for preview
      vim.g.mkdp_port = ""
      -- Page title
      vim.g.mkdp_page_title = "「${name}」"
      -- Theme (dark/light)
      vim.g.mkdp_theme = "dark"
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
      { "<leader>mS", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview" },
    },
  },

  -- render-markdown.nvim - Inline preview in Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      heading = {
        enabled = true,
        sign = true,
        position = "overlay",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        signs = { "󰫎 " },
        width = "full",
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_prefix = false,
        above = "▄",
        below = "▀",
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
      code = {
        enabled = true,
        sign = true,
        style = "full",
        position = "left",
        language_pad = 0,
        disable_background = { "diff" },
        width = "full",
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = "thin",
        above = "▄",
        below = "▀",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },
      dash = {
        enabled = true,
        icon = "─",
        width = "full",
        highlight = "RenderMarkdownDash",
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
        left_pad = 0,
        right_pad = 0,
        highlight = "RenderMarkdownBullet",
      },
      checkbox = {
        enabled = true,
        position = "inline",
        unchecked = {
          icon = "󰄱 ",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "󰱒 ",
          highlight = "RenderMarkdownChecked",
        },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
      quote = {
        enabled = true,
        icon = "▋",
        repeat_linebreak = false,
        highlight = "RenderMarkdownQuote",
      },
      pipe_table = {
        enabled = true,
        preset = "none",
        style = "full",
        cell = "padded",
        alignment_indicator = "━",
        border = {
          "┌", "┬", "┐",
          "├", "┼", "┤",
          "└", "┴", "┘",
          "│", "─",
        },
        head = "RenderMarkdownTableHead",
        row = "RenderMarkdownTableRow",
        filler = "RenderMarkdownTableFill",
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
        abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
        todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
        success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
        question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
        failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
        danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
        bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
        example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
        quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
      },
      link = {
        enabled = true,
        image = "󰥶 ",
        email = "󰀓 ",
        hyperlink = "󰌹 ",
        highlight = "RenderMarkdownLink",
        custom = {
          web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
        },
      },
      sign = {
        enabled = true,
        highlight = "RenderMarkdownSign",
      },
      indent = {
        enabled = false,
        per_level = 2,
      },
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          rendered = 3,
        },
        concealcursor = {
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          rendered = "",
        },
      },
      latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
        top_pad = 0,
        bottom_pad = 0,
      },
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
    },
  },

  -- Treesitter for Markdown
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
        "latex",
      })
    end,
  },

  -- Markdown table of contents generator
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    cmd = { "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "UpdateToc", "RemoveToc" },
    keys = {
      { "<leader>mt", "<cmd>GenTocGFM<cr>", desc = "Generate TOC (GitHub)" },
      { "<leader>mT", "<cmd>UpdateToc<cr>", desc = "Update TOC" },
    },
  },

  -- Which-key group
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "Markdown", icon = "" },
      },
    },
  },
}
