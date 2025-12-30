-- Neo-tree configuration with line numbers and hidden files
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = "none",
          ["H"] = "toggle_hidden", -- H para toggle arquivos ocultos
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- Mostra itens filtrados (ocultos) com opacidade reduzida
          hide_dotfiles = false, -- Mostra arquivos que começam com .
          hide_gitignored = false, -- Mostra arquivos do .gitignore
          hide_hidden = false, -- No Windows, mostra arquivos com atributo hidden
          hide_by_name = {
            -- Adicione aqui arquivos que você NUNCA quer ver
            -- ".git",
            -- ".DS_Store",
          },
          never_show = {
            -- Arquivos que nunca serão mostrados
            -- ".DS_Store",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.opt_local.number = true
            vim.opt_local.relativenumber = true
          end,
        },
      },
    },
    keys = {
      {
        "<leader>fh",
        function()
          require("neo-tree.command").execute({ action = "show", reveal = true, toggle = true })
        end,
        desc = "Explorer (show hidden)",
      },
    },
  },
}
