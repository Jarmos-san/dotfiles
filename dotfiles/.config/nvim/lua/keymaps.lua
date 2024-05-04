-- Module of keymaps & bindings which makes using Neovim a pleasure

local wk = require("which-key")
local telescope = require("telescope.builtin")
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

wk.register({
  -- Keymaps to manage the inbuilt terminal within Neovim itself
  ["<leader>t"] = {
    name = "+Terminal",
    t = { "<CMD>vsplit term://zsh<CR>", "Open the terminal prompt" },
  },
  -- VSCode-like quick file management UI
  ["<leader>f"] = {
    name = "+File",
    f = { telescope.find_files, "Find files" },
    o = { telescope.oldfiles, "Open recent files" },
    n = { "<CMD>enew<CR>", "Open a new file" },
    h = { telescope.help_tags, "Open the help tags menu" },
    g = { telescope.live_grep, "Perform a grep on file contents" },
  },
  -- Easier & quicker buffer management keymaps
  ["<leader>b"] = {
    name = "+Buffer",
    d = { bdelete, "Delete the current buffer" },
    l = { "<CMD>Telescope buffers<CR>", "List all loaded buffers" },
    n = { "<CMD>bnext<CR>", "Load the next hidden buffer" },
  },
  -- Keymaps to manage & show LSP stuff
  ["<leader>l"] = {
    name = "+LSP",
    t = { "<CMD>TroubleToggle<CR>", "Toggle open/close the diagnostics list" },
  },
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

-- Clear the search highlight by pressing <ESC>
map({ "i", "n" }, "<esc>", "<CMD>nohlsearch<CR><esc>", { desc = "Escape & clear highlighted search" })

-- Clear search, diff update & redraw, see credit below:
-- https://github.com/LazyVim/LazyVim/blob/befa6c67a4387b0db4f8421d463f5d03f91dc829/lua/lazyvim/config/keymaps.lua#L58
map(
  "n",
  "<leader>ur",
  "<CMD>nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>",
  { desc = "Redraw, clear the search highlight & update diff" }
)

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
