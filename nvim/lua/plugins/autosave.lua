-- Autosave configuration (similar to VSCode)
return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      -- Trigger events
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" }, -- Save immediately on these events
        defer_save = { "InsertLeave", "TextChanged" }, -- Save after debounce on these events
        cancel_deferred_save = { "InsertEnter" }, -- Cancel deferred save when entering insert mode
      },
      -- Debounce delay in milliseconds (time to wait before saving)
      debounce_delay = 1000, -- 1 second after last change
      -- Write all buffers vs only current
      write_all_buffers = false,
      -- Don't save if buffer is not modified
      noautocmd = false,
      -- Lockmarks to prevent marks from being lost
      lockmarks = false,
      -- Condition function - return false to not save
      condition = function(buf)
        local fn = vim.fn

        -- Don't save if buffer is not modifiable
        if fn.getbufvar(buf, "&modifiable") == 0 then
          return false
        end

        -- Don't save special buffer types
        local buftype = fn.getbufvar(buf, "&buftype")
        if buftype ~= "" then
          return false
        end

        -- Don't save for certain filetypes
        local filetype = fn.getbufvar(buf, "&filetype")
        local excluded_filetypes = {
          "gitcommit",
          "gitrebase",
          "harpoon",
          "oil",
          "neo-tree",
          "TelescopePrompt",
          "lazy",
          "mason",
        }
        if vim.tbl_contains(excluded_filetypes, filetype) then
          return false
        end

        -- Don't save if file doesn't exist yet (new unsaved buffer)
        local filename = fn.expand("%:p")
        if filename == "" then
          return false
        end

        return true
      end,
      -- Callbacks
      callbacks = {
        -- Called when a save is enabled
        enabling = nil,
        -- Called when a save is disabled
        disabling = nil,
        -- Called before a save is attempted
        before_asserting_save = nil,
        -- Called before a save is attempted (when save conditions are met)
        before_saving = function()
          -- Uncomment to show a message before saving
          -- vim.notify("Auto-saving...", vim.log.levels.INFO, { title = "auto-save" })
        end,
        -- Called after a save is attempted
        after_saving = function()
          -- Uncomment to show a message after saving
          -- vim.notify("Saved at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO, { title = "auto-save" })
        end,
      },
    },
    keys = {
      {
        "<leader>ua",
        "<cmd>ASToggle<cr>",
        desc = "Toggle Auto-Save",
      },
    },
  },
}
