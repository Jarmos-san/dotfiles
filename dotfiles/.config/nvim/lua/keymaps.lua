-- Module of keymaps & bindings which makes using Neovim a pleasure

local wk = require("which-key")

-- Utlity function to make keybind mappings easier & DRY
local map = function(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Open the starter dashboard if the buffer list is empty
local open_starter_if_empty_buffer = function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_empty = vim.api.nvim_buf_get_name(buf_id) == "" and vim.bo[buf_id].filetype == ""
  if not is_empty then
    return
  end

  vim.cmd("Neotree close")
  require("mini.starter").open()
  vim.cmd(buf_id .. "bwipeout")
end

-- Delete all buffers and open the starter dashboard
local bdelete = function()
  require("mini.bufremove").delete()
  open_starter_if_empty_buffer()
end

-- Wrapper function to safely pass to Which-Key to open a terminal session
local open_terminal = function()
  -- INFO: The empty string is a hack to immediately open a Shell session without a user prompt
  require("terminal").run("")
end

wk.register({
  -- Keymaps to manage the inbuilt terminal within Neovim itself
  ["<leader>t"] = {
    name = "+Terminal",
    t = { open_terminal, "Toggle the terminal open/close" },
  },
  -- VSCode-like quick file management UI
  ["<leader>f"] = {
    name = "+File",
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    o = { "<cmd>Telescope oldfiles<cr>", "Open recent files" },
    n = { "<cmd>enew<cr>", "Open a new file" },
    h = { "<cmd>Telescope help_tags<cr>", "Open the help tags menu" },
    e = { "<cmd>Neotree toggle<cr>", "Toggle the file explorer open/close" },
  },
  -- Easier & quicker buffer management keymaps
  ["<leader>b"] = {
    name = "+Buffer",
    -- d = { "<cmd>lua require('bufdelete').bufdelete(o, true)<cr>", "Delete the current buffer" },
    d = { bdelete, "Delete the current buffer" },
    l = { "<cmd>Telescope buffers<cr>", "List all loaded buffers" },
    n = { "<cmd>bnext<cr>", "Load the next hidden buffer" },
  },
  -- Keymaps to manage & show LSP stuff
  ["<leader>l"] = {
    name = "+LSP",
    d = { "<cmd>TroubleToggle<cr>", "Toggle open/close the diagnostics list" },
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
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })

-- Clear the search highlight by pressing <ESC>
map({ "i", "n" }, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape & clear highlighted search" })

-- Clear search, diff update & redraw, see credit below:
-- https://github.com/LazyVim/LazyVim/blob/befa6c67a4387b0db4f8421d463f5d03f91dc829/lua/lazyvim/config/keymaps.lua#L58
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>",
  { desc = "Redraw, clear the search highlight & update diff" }
)

-- Save the file like any other "normal" IDEs
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>write<cr><esc>", { desc = "Save the contents of the buffer" })

-- Better & easier indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
