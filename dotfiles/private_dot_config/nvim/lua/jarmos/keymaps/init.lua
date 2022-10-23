--[
-- =================================================================================
-- Setup some bare minimum keymaps for easier navigation inside the Neovim environment.
-- =================================================================================
--]

local wk = require("which-key")

local map = vim.keymap

-- Disable the arrow keys
map.set({ "i", "n" }, "<Up>", "<NOP>")
map.set({ "i", "n" }, "<Down>", "<NOP>")
map.set({ "i", "n" }, "<Left>", "<NOP>")
map.set({ "i", "n" }, "<Right>", "<NOP>")

-- Better form of navigation without using the arrow keys.
map.set("i", "<C-h>", "<Left>")
map.set("i", "<C-j>", "<Down>")
map.set("i", "<C-k>", "<Up>")
map.set("i", "<C-l>", "<Right>")

-- Basic keymaps for better navigation within Neovim.
map.set("i", "jk", "<Esc>") -- Press "jk" in quick succession to exit Insert mode.
map.set("n", "H", "<Home>") -- Press capital "h" to move to the beginning of a line in Normal mode.
map.set("n", "L", "<End>") -- Press capital "l" to move to the end of the line in Normal mode.

map.set("n", "<C-s>", "<CMD>write!<CR>") -- Press "Ctrl + s" to save the modifications made in a buffer.
map.set("n", "<C-a>", "ggVG") -- Press "Ctrl + a" to select all texts in a buffer.

map.set("n", "<C-o>", "<CMD>tabedit<CR>") -- Press "Ctrl + o" to open a new tab.
map.set("n", "<C-c>", "<CMD>tabclose<CR>") -- Press "Ctrl + c" to close an open tab.

wk.register({
  ["<leader>f"] = {
    name = "file",
    e = { "<CMD>Neotree float toggle<CR>", "Toggle the File Explorer." },
  },
  ["<leader>b"] = {
    name = "buffer",
    c = { "<CMD>bdelete<CR>", "Close & delete the current buffer." },
    n = { "<CMD>bnext<CR>", "Switch to the next buffer currently open in the buffer list." },
  },
})
