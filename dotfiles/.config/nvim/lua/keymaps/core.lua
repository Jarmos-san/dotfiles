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

---Deletes the current buffer using `mini.bufremove` and restores the
---`mini-starter` dashboard if the resulting buffer is empty.
---
---The function delegates the buffer deletion to `mini.bufremove.delete()` to
---ensure proper window preservation semantics. It then focuses the new buffer
---and if the current buffer is unnamed and has no filetype (i.e.,) an empty
---scratch buffer, it opens the `mini.starter` dashboard and wipes out the
---temporary empty buffer.
---
---This prevents Neovim from remaining in an unintended empty buffer state
---after deletion.
---
---@return nil
local bdelete = function()
  -- Delete the current buffer while preserving window layout
  require("mini.bufremove").delete()

  -- Handle Neovim not deleting a scratch buffer
  local buf = vim.api.nvim_get_current_buf()
  local is_empty = vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].filetype == ""
  if not is_empty then
    return
  end

  -- Open the starter dashboard and wipeout the empty buffer
  require("mini.starter").open()
  vim.cmd(buf .. "bwipeout")
end

---@type DeclarativeKeymap[]
local keymaps = {
  {
    mode = "i",
    lhs = "jk",
    rhs = "<ESC>",
    opts = { desc = "Change to Normal mode" },
  },
  {
    mode = "n",
    lhs = "H",
    rhs = "<HOME>",
    opts = { desc = "Move to the beginning of the line" },
  },
  {
    mode = "n",
    lhs = "L",
    rhs = "<END>",
    opts = { desc = "Move to the end of the line" },
  },
  {
    mode = "n",
    lhs = "<C-Up>",
    rhs = "<CMD>resize +2<CR>",
    opts = { desc = "Increase the window height" },
  },
  {
    mode = "n",
    lhs = "<C-Down>",
    rhs = "<CMD>resize -2<CR>",
    opts = { desc = "Decrease the window height" },
  },
  {
    mode = "n",
    lhs = "<C-Right>",
    rhs = "<CMD>vertical resize +2<CR>",
    opts = { desc = "Increase the window width" },
  },
  {
    mode = "n",
    lhs = "<C-Left>",
    rhs = "<CMD>vertical resize +2<CR>",
    opts = { desc = "Increase the window width" },
  },
  {
    mode = "v",
    lhs = "<",
    rhs = "<gv",
    opts = { desc = "Shift lines leftwards in visual mode" },
  },
  {
    mode = "v",
    lhs = ">",
    rhs = ">gv",
    opts = { desc = "Shift lines rightwards in visual mode" },
  },
  {
    mode = "n",
    lhs = "gQ",
    rhs = "<NOP>",
    opts = { desc = "Disable Ex mode" },
  },
  {
    mode = "i",
    lhs = "<M-h>",
    rhs = "<Left>",
    opts = { desc = "Move left in Insert mode" },
  },
  {
    mode = "i",
    lhs = "<M-j>",
    rhs = "<Down>",
    opts = { desc = "Move down in Insert mode" },
  },
  {
    mode = "i",
    lhs = "<M-k>",
    rhs = "<Up>",
    opts = { desc = "Move up in Insert mode" },
  },
  {
    mode = "i",
    lhs = "<M-l>",
    rhs = "<Right>",
    opts = { desc = "Move right in Insert mod," },
  },
  {
    mode = "n",
    lhs = "<leader>bn",
    rhs = "<CMD>bnext<CR>",
    opts = { desc = "Change to the next buffer" },
  },
  {
    mode = "n",
    lhs = "<leader>bp",
    rhs = "<CMD>bprevious<CR>",
    opts = { desc = "Change to the previous buffer" },
  },
  {
    mode = "n",
    lhs = "<ESC><ESC>",
    rhs = "<CMD>set nohlsearch<CR>",
    opts = { desc = "Clear the search highlights" },
  },
  {
    mode = "n",
    lhs = "<leader>w",
    rhs = "<CMD>silent write<CR>",
    opts = { desc = "write buffer contents to file" },
  },
  {
    mode = "n",
    lhs = "<leader>bd",
    rhs = bdelete,
    opts = { desc = "Delete the buffer contents from the Neovim session" },
  },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map.mode, map.lhs, map.rhs, map.opts)
end
