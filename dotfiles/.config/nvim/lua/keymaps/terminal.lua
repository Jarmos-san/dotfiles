---@brief
---
---Module containing the keymaps for handling an embeddedd terminal within Neovim.

local terminal = require("terminal").setup

---@type DeclarativeKeymap[]
local keymaps = {
  {
    mode = "n",
    lhs = "<leader>t",
    rhs = terminal.float,
    opts = { desc = "Open the terminal prompt in a horizontal split" },
  },
  {
    mode = "n",
    lhs = "<leader>tv",
    rhs = terminal.vertical,
    opts = { desc = "Open the terminal prompt in vertical split" },
  },
  {
    mode = "t",
    lhs = "jk",
    rhs = "<C-\\><C-n>",
    opts = { desc = "Exit terminal mode" },
  },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map.mode, map.lhs, map.rhs, map.opts)
end
