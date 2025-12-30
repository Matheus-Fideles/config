-- GitHub Integration - Full UI experience
return {
  -- Octo.nvim - Complete GitHub UI inside Neovim
  -- Review PRs, manage issues, view comments, all without leaving the editor
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    opts = {
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      default_to_resolve_conv = false,
      ssh_aliases = {},
      picker = "telescope",
      picker_config = {
        use_emojis = true,
        mappings = {
          open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL" },
          checkout_pr = { lhs = "<C-o>", desc = "Checkout PR" },
          merge_pr = { lhs = "<C-r>", desc = "Merge PR" },
        },
      },
      comment_icon = "",
      outdated_icon = "󰅒 ",
      resolved_icon = " ",
      reaction_viewer_hint_icon = " ",
      user_icon = " ",
      timeline_marker = " ",
      timeline_indent = "2",
      right_bubble_delimiter = "",
      left_bubble_delimiter = "",
      github_hostname = "",
      snippet_context_lines = 4,
      gh_cmd = "gh",
      gh_env = {},
      timeout = 5000,
      default_merge_method = "squash",
      ui = {
        use_signcolumn = true,
        use_statuscolumn = true,
      },
      issues = {
        order_by = {
          field = "CREATED_AT",
          direction = "DESC",
        },
      },
      pull_requests = {
        order_by = {
          field = "CREATED_AT",
          direction = "DESC",
        },
        always_select_remote_on_create = false,
      },
      file_panel = {
        size = 10,
        use_icons = true,
      },
      colors = {
        white = "#ffffff",
        grey = "#2A354C",
        black = "#000000",
        red = "#fdb8c0",
        dark_red = "#da3633",
        green = "#acf2bd",
        dark_green = "#238636",
        yellow = "#d3c846",
        dark_yellow = "#735c0f",
        blue = "#58a6ff",
        dark_blue = "#0366d6",
        purple = "#6f42c1",
      },
      mappings_disable_default = false,
      mappings = {
        issue = {
          close_issue = { lhs = "<leader>gic", desc = "Close issue" },
          reopen_issue = { lhs = "<leader>gio", desc = "Reopen issue" },
          list_issues = { lhs = "<leader>gil", desc = "List issues" },
          reload = { lhs = "<C-r>", desc = "Reload" },
          open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL" },
          add_assignee = { lhs = "<leader>giaa", desc = "Add assignee" },
          remove_assignee = { lhs = "<leader>giad", desc = "Remove assignee" },
          create_label = { lhs = "<leader>gilc", desc = "Create label" },
          add_label = { lhs = "<leader>gila", desc = "Add label" },
          remove_label = { lhs = "<leader>gild", desc = "Remove label" },
          goto_issue = { lhs = "<leader>gig", desc = "Go to issue" },
          add_comment = { lhs = "<leader>gica", desc = "Add comment" },
          delete_comment = { lhs = "<leader>gicd", desc = "Delete comment" },
          next_comment = { lhs = "]c", desc = "Next comment" },
          prev_comment = { lhs = "[c", desc = "Previous comment" },
          react_hooray = { lhs = "<leader>girp", desc = "React hooray" },
          react_heart = { lhs = "<leader>girh", desc = "React heart" },
          react_eyes = { lhs = "<leader>gire", desc = "React eyes" },
          react_thumbs_up = { lhs = "<leader>gir+", desc = "React +1" },
          react_thumbs_down = { lhs = "<leader>gir-", desc = "React -1" },
          react_rocket = { lhs = "<leader>girr", desc = "React rocket" },
          react_laugh = { lhs = "<leader>girl", desc = "React laugh" },
          react_confused = { lhs = "<leader>girc", desc = "React confused" },
        },
        pull_request = {
          checkout_pr = { lhs = "<leader>gpo", desc = "Checkout PR" },
          merge_pr = { lhs = "<leader>gpm", desc = "Merge PR" },
          squash_and_merge_pr = { lhs = "<leader>gpsm", desc = "Squash and merge" },
          rebase_and_merge_pr = { lhs = "<leader>gprm", desc = "Rebase and merge" },
          list_commits = { lhs = "<leader>gpc", desc = "List commits" },
          list_changed_files = { lhs = "<leader>gpf", desc = "List changed files" },
          show_pr_diff = { lhs = "<leader>gpd", desc = "Show PR diff" },
          add_reviewer = { lhs = "<leader>gpva", desc = "Add reviewer" },
          remove_reviewer = { lhs = "<leader>gpvd", desc = "Remove reviewer" },
          close_issue = { lhs = "<leader>gpic", desc = "Close PR" },
          reopen_issue = { lhs = "<leader>gpio", desc = "Reopen PR" },
          list_issues = { lhs = "<leader>gpil", desc = "List PR issues" },
          reload = { lhs = "<C-r>", desc = "Reload" },
          open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL" },
          goto_file = { lhs = "gf", desc = "Go to file" },
          add_assignee = { lhs = "<leader>gpaa", desc = "Add assignee" },
          remove_assignee = { lhs = "<leader>gpad", desc = "Remove assignee" },
          create_label = { lhs = "<leader>gplc", desc = "Create label" },
          add_label = { lhs = "<leader>gpla", desc = "Add label" },
          remove_label = { lhs = "<leader>gpld", desc = "Remove label" },
          goto_issue = { lhs = "<leader>gpg", desc = "Go to issue" },
          add_comment = { lhs = "<leader>gpca", desc = "Add comment" },
          delete_comment = { lhs = "<leader>gpcd", desc = "Delete comment" },
          next_comment = { lhs = "]c", desc = "Next comment" },
          prev_comment = { lhs = "[c", desc = "Previous comment" },
          react_hooray = { lhs = "<leader>gprp", desc = "React party" },
          react_heart = { lhs = "<leader>gprh", desc = "React heart" },
          react_eyes = { lhs = "<leader>gpre", desc = "React eyes" },
          react_thumbs_up = { lhs = "<leader>gpr+", desc = "React +1" },
          react_thumbs_down = { lhs = "<leader>gpr-", desc = "React -1" },
          react_rocket = { lhs = "<leader>gprr", desc = "React rocket" },
          react_laugh = { lhs = "<leader>gprl", desc = "React laugh" },
          react_confused = { lhs = "<leader>gprc", desc = "React confused" },
          review_start = { lhs = "<leader>gpvs", desc = "Start review" },
          review_resume = { lhs = "<leader>gpvr", desc = "Resume review" },
        },
        review_thread = {
          goto_issue = { lhs = "<leader>gig", desc = "Go to issue" },
          add_comment = { lhs = "<leader>gca", desc = "Add comment" },
          add_suggestion = { lhs = "<leader>gsa", desc = "Add suggestion" },
          delete_comment = { lhs = "<leader>gcd", desc = "Delete comment" },
          next_comment = { lhs = "]c", desc = "Next comment" },
          prev_comment = { lhs = "[c", desc = "Previous comment" },
          select_next_entry = { lhs = "]q", desc = "Next changed file" },
          select_prev_entry = { lhs = "[q", desc = "Previous changed file" },
          select_first_entry = { lhs = "[Q", desc = "First changed file" },
          select_last_entry = { lhs = "]Q", desc = "Last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
          toggle_viewed = { lhs = "<leader>gv", desc = "Toggle viewed" },
          goto_file = { lhs = "gf", desc = "Go to file" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "Approve review" },
          comment_review = { lhs = "<C-m>", desc = "Comment review" },
          request_changes = { lhs = "<C-r>", desc = "Request changes" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
        },
        review_diff = {
          submit_review = { lhs = "<leader>gvs", desc = "Submit review" },
          discard_review = { lhs = "<leader>gvd", desc = "Discard review" },
          add_review_comment = { lhs = "<leader>gca", desc = "Add comment" },
          add_review_suggestion = { lhs = "<leader>gsa", desc = "Add suggestion" },
          focus_files = { lhs = "<leader>gf", desc = "Focus files" },
          toggle_files = { lhs = "<leader>gt", desc = "Toggle files" },
          next_thread = { lhs = "]t", desc = "Next thread" },
          prev_thread = { lhs = "[t", desc = "Previous thread" },
          select_next_entry = { lhs = "]q", desc = "Next file" },
          select_prev_entry = { lhs = "[q", desc = "Previous file" },
          select_first_entry = { lhs = "[Q", desc = "First file" },
          select_last_entry = { lhs = "]Q", desc = "Last file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review" },
          toggle_viewed = { lhs = "<leader>gv", desc = "Toggle viewed" },
          goto_file = { lhs = "gf", desc = "Go to file" },
        },
        file_panel = {
          submit_review = { lhs = "<leader>gvs", desc = "Submit review" },
          discard_review = { lhs = "<leader>gvd", desc = "Discard review" },
          next_entry = { lhs = "j", desc = "Next file" },
          prev_entry = { lhs = "k", desc = "Previous file" },
          select_entry = { lhs = "<cr>", desc = "Select file" },
          refresh_files = { lhs = "R", desc = "Refresh files" },
          focus_files = { lhs = "<leader>gf", desc = "Focus files" },
          toggle_files = { lhs = "<leader>gt", desc = "Toggle files" },
          select_next_entry = { lhs = "]q", desc = "Next file" },
          select_prev_entry = { lhs = "[q", desc = "Previous file" },
          select_first_entry = { lhs = "[Q", desc = "First file" },
          select_last_entry = { lhs = "]Q", desc = "Last file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review" },
          toggle_viewed = { lhs = "<leader>gv", desc = "Toggle viewed" },
        },
      },
    },
    keys = {
      -- General GitHub commands
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gI", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gr", "<cmd>Octo repo list<cr>", desc = "List Repos" },
      { "<leader>gS", "<cmd>Octo search<cr>", desc = "Search GitHub" },
      -- Quick actions
      { "<leader>ga", "<cmd>Octo actions<cr>", desc = "GitHub Actions" },
      { "<leader>gc", "<cmd>Octo comment add<cr>", desc = "Add Comment" },
      { "<leader>gR", "<cmd>Octo review start<cr>", desc = "Start Review" },
    },
  },

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-k>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
      },
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        ["."] = false,
      },
    },
  },

  -- GitHub Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4o",
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      auto_follow_cursor = false,
      show_help = true,
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ax", "<cmd>CopilotChatReset<cr>", desc = "Reset Copilot Chat" },
      { "<leader>aq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end, desc = "Quick Chat" },
      -- Code actions
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review Code", mode = { "n", "v" } },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix Code", mode = { "n", "v" } },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code", mode = { "n", "v" } },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests", mode = { "n", "v" } },
      -- Commit
      { "<leader>am", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },
      { "<leader>aM", "<cmd>CopilotChatCommitStaged<cr>", desc = "Generate Commit (Staged)" },
    },
  },

  -- Diffview for better diff experience
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
    },
  },

  -- Which-key groups
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>g", group = "Git/GitHub", icon = "" },
        { "<leader>a", group = "AI/Copilot", icon = "" },
      },
    },
  },
}
