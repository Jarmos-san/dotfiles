---@brief
---
---Module for handling the LSP-based keymaps

local telescope = require("telescope.builtin")

---@type DeclarativeKeymap[]
local keymaps = {
  {
    mode = "n",
    lhs = "gd",
    rhs = telescope.lsp_definitions,
    opts = { desc = "Jump to the object definition" },
  },
  {
    mode = "n",
    lhs = "gD",
    rhs = vim.lsp.buf.declaration,
    opts = { desc = "Jump to the object declaration" },
  },
  {
    mode = "n",
    lhs = "gT",
    rhs = telescope.lsp_type_definitions,
    opts = { desc = "Get the type documentations" },
  },
  {
    mode = "n",
    lhs = "gi",
    rhs = vim.lsp.buf.implementation,
    opts = { desc = "Jump to the implementation" },
  },
  {
    mode = "n",
    lhs = "K",
    rhs = vim.lsp.buf.hover,
    opts = { desc = "Open the documentations of the object" },
  },
  {
    mode = "n",
    lhs = "<C-S>",
    rhs = vim.lsp.buf.signature_help,
    opts = { desc = "Get the help documentations" },
  },
  {
    mode = "n",
    lhs = "gr",
    rhs = vim.lsp.buf.rename,
    opts = { desc = "Rename the object under the cursor" },
  },
  {
    mode = "n",
    lhs = "gR",
    rhs = telescope.lsp_references,
    opts = { desc = "Jump to the reference of the object" },
  },
  {
    mode = "n",
    lhs = "gra",
    rhs = vim.lsp.buf.code_action,
    opts = { desc = "Open available code actions" },
  },
  {
    mode = "n",
    lhs = "<leader>wa",
    rhs = vim.lsp.buf.add_workspace_folder,
    opts = { desc = "Add workspace folder" },
  },
  {
    mode = "n",
    lhs = "<leader>wr",
    rhs = vim.lsp.buf.remove_workspace_folder,
    opts = { desc = "Remove workspace folder" },
  },
  {
    mode = "n",
    lhs = "<leader>wl",
    rhs = vim.lsp.buf.list_workspace_folders,
    opts = { desc = "List workspace folders" },
  },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map.mode, map.lhs, map.rhs, map.opts)
end
