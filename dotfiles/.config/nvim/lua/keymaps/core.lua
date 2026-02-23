---@brief
---
---Module containing the core utility keymaps for using Neovim more effectively.

---@alias KeymapMode
---| '"n"'  # Normal
---| '"i"'  # Insert
---| '"v"'  # Visual
---| '"x"'  # Visual block
---| '"s"'  # Select
---| '"o"'  # Operator-pending
---| '"t"'  # Terminal
---| '"c"'  # Command

---@class DeclarativeKeymap
---@field mode KeymapMode|KeymapMode[]
---@field lhs string
---@field rhs string|function
---@field opts? vim.keymap.set.Opts

---@type DeclarativeKeymap[]
local keymaps = {
  { mode = "i", lhs = "jk", rhs = "<ESC>", opts = { desc = "Change to Normal mode" } },
  { mode = "n", lhs = "H", rhs = "<HOME>", opts = { desc = "Move to the beginning of the line" } },
  { mode = "n", lhs = "L", rhs = "<END>", opts = { desc = "Move to the end of the line" } },
  { mode = "n", lhs = "<C-Up>", rhs = "<CMD>resize +2<CR>", opts = { desc = "Increase the window height" } },
  { mode = "n", lhs = "<C-Down>", rhs = "<CMD>resize -2<CR>", opts = { desc = "Decrease the window height" } },
  { mode = "n", lhs = "<C-Right>", rhs = "<CMD>vertical resize +2<CR>", opts = { desc = "Increase the window width" } },
  { mode = "n", lhs = "<C-Left>", rhs = "<CMD>vertical resize +2<CR>", opts = { desc = "Increase the window width" } },
  { mode = "v", lhs = "<", rhs = "<gv", opts = { desc = "Shift lines leftwards in visual mode" } },
  { mode = "v", lhs = ">", rhs = ">gv", opts = { desc = "Shift lines rightwards in visual mode" } },
  { mode = "n", lhs = "gQ", rhs = "<NOP>", opts = { desc = "Disable Ex mode" } },
  { mode = "i", lhs = "<M-h>", rhs = "<Left>", opts = { desc = "Move left in Insert mode" } },
  { mode = "i", lhs = "<M-j>", rhs = "<Down>", opts = { desc = "Move down in Insert mode" } },
  { mode = "i", lhs = "<M-k>", rhs = "<Up>", opts = { desc = "Move up in Insert mode" } },
  { mode = "i", lhs = "<M-l>", rhs = "<Right>", opts = { desc = "Move right in Insert mod," } },
  { mode = "n", lhs = "<leader>bn", rhs = "<CMD>bnext<CR>", opts = { desc = "Change to the next buffer" } },
  { mode = "n", lhs = "<leader>bp", rhs = "<CMD>bprevious<CR>", opts = { desc = "Change to the previous buffer" } },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map.mode, map.lhs, map.rhs, map.opts)
end
