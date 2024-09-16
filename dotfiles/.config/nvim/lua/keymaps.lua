-- Module of keymaps & bindings which makes using Neovim a pleasure

local wk = require("which-key")
local telescope = require("telescope.builtin")
local utils = require("utils")
local map = require("utils").map

-- Open the starter dashboard if the buffer list is empty
local open_starter_if_empty_buffer = function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_empty = vim.api.nvim_buf_get_name(buf_id) == "" and vim.bo[buf_id].filetype == ""
  if not is_empty then
    return
  end

  require("mini.starter").open()
  vim.cmd(buf_id .. "bwipeout")
end

-- Delete all buffers and open the starter dashboard
local bdelete = function()
  require("mini.bufremove").delete()
  open_starter_if_empty_buffer()
end

-- Use the ":Telescope git_files" command if the current directory is version controlled with Git
local find_files = function()
  if utils.is_git_repo() or utils.has_git_dir() then
    telescope.git_files()
  else
    telescope.find_files()
  end
end

wk.add({
  -- Mappings for handling buffer related operations
  { "<leader>b", group = "Buffer", icon = "󱥊" },
  { "<leader>bd", bdelete, desc = "Delete the current buffer", icon = "󱥊" },
  { "<leader>bl", telescope.buffers, desc = "List all loaded buffers", icon = "󱥊" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Load the next buffer", icon = "󱥊" },
  { "<leader>bm", telescope.marks, desc = "List all markers in current buffer", icon = "󱥊" },
  { "<leader>bh", "<cmd>nohlsearch<cr>", desc = "Clear the search highlights from the buffer", icon = "󱥊" },
  { "<leader>br", telescope.registers, desc = "Show the contents of the registers", icon = "󱥊" },

  -- Mappings to handle file operations
  { "<leader>f", group = "Files", icon = "󱥊" },
  { "<leader>ff", find_files, desc = "Find files", icon = "󱥊" },
  { "<leader>fn", "<cmd>enew<cr>", desc = "Open a new file", icon = "󱥊" },
  { "<leader>fo", telescope.oldfiles, desc = "Open recently opened files", icon = "󱥊" },
  { "<leader>fh", telescope.help_tags, desc = "Open the help tags menu", icon = "󱥊" },
  { "<leader>fg", telescope.live_grep, desc = "Perform a live grep on file contents", icon = "󱥊" },

  -- Mappings to handle the builtin terminal capabilities
  { "<leader>t", group = "Terminal" },
  { "<leader>tt", "<cmd>split term://zsh<cr>", desc = "Open the terminal prompt" },
})

-- Change to Normal mode by pressing "jk" in quick succession
map("i", "jk", "<esc>", { desc = "Change to Normal mode" })

-- Select all contents of the buffer by pressing "Ctrl + a" like every other IDE
map("n", "<C-a>", "ggVG", { desc = "Select all contents in the buffer" })

-- Easier navigation to the beginning or the start of the line
map("n", "H", "<Home>", { desc = "Move to the beginning of the line" })
map("n", "L", "<End>", { desc = "Move to the end of the line" })

-- "Better up/down navigation" (??) not sure what its supposed to do, see the credit below:
-- https://github.com/LazyVim/LazyVim/blob/befa6c67a4387b0db4f8421d463f5d03f91dc829/lua/lazyvim/config/keymaps.lua#L16
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Navigate around windows more easily with the "hjkl" keys
map("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Go to lower window" })
map("n", "<leader>k", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })

-- Resize windows using <Ctrl + Arrow keys>
map("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Increase window width" })

-- Save the file like any other "normal" IDEs
map({ "i", "v", "n", "s" }, "<C-s>", "<CMD>write<CR><esc>", { desc = "Save the contents of the buffer" })

-- Better & easier indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Disable the redundant (and sometimes annoying "Ex mode")
-- INFO: See the docs at ":h gQ" for more info on what its supposed to do
map("n", "gQ", "<NOP>")

-- Exit terminal mode in builtin terminal with an easier to use shortcut
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Easier navigation in Insert mode without the arrow keys!
map("i", "<M-h>", "<Left>", { desc = "Move left in Insert mode" })
map("i", "<M-j>", "<Down>", { desc = "Move down in Insert mode" })
map("i", "<M-k>", "<Up>", { desc = "Move up in Insert mode" })
map("i", "<M-l>", "<Right>", { desc = "Move right in Insert mode" })

-- Configure Neovim to delete text without copying them to the unnamed register
map("n", "d", '"_d', { desc = "Delete a line of texting without storing it in a register" })
