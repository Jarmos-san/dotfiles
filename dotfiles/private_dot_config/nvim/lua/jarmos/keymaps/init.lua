--[
-- =================================================================================
-- Setup some bare minimum keymaps for easier navigation inside the Neovim environment.
-- =================================================================================
--]

local map = vim.keymap
local opts = {
  silent = true,
}

-- Basic keymaps for better navigation within Neovim.
map.set("i", "jk", "<Esc>") -- Press "jk" in quick succession to exit Insert mode.
map.set("n", "H", "<Home>") -- Press capital "h" to move to the beginning of a line in Normal mode.
map.set("n", "L", "<End>") -- Press capital "l" to move to the end of the line in Normal mode.

map.set("n", "<C-s>", ":write!<CR>") -- Press "Ctrl + s" to save the modifications made in a buffer.
map.set("n", "<C-a>", "ggVG") -- Press "Ctrl + a" to select all texts in a buffer.

map.set("n", "<C-o>", ":tabedit<CR>") -- Press "Ctrl + o" to open a new tab.
map.set("n", "<C-c>", ":tabclose<CR>") -- Press "Ctrl + c" to close an open tab.

map.set("n", "<leader>fe", ":Neotree toggle<CR>", opts) -- Toggle the file-explorer open/close more easily.
map.set("n", "<leader>bc", ":bdelete<CR>", opts) -- Close & delete the current buffer from the buffer list.
map.set("n", "<leader>bb", ":bnext<CR>", opts) -- Switch to the next buffer currently open in the buffer-list.
