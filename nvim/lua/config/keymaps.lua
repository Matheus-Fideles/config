local keymap = vim.keymap
local opts = { noremap = true, silent = true }


-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window (duplica arquivo atual)
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Split window com seleção de arquivo
keymap.set("n", "sS", ":split ", opts)
keymap.set("n", "sV", ":vsplit ", opts)

-- Close split window
keymap.set("n", "sc", "<C-w>c", opts)  -- split close (fecha atual)
keymap.set("n", "so", "<C-w>o", opts)  -- split only (fecha outras)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<C-k>", function()
	vim.diagnostic.goto_prev()
end, opts)

keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, opts)

keymap.set("n", "<leader>dl", function()
	vim.diagnostic.setloclist()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)


