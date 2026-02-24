-- Module of keymaps & bindings which makes using Neovim a pleasure

local M = {}

M.setup = function()
  require("keymaps.core")
  require("keymaps.terminal")
  require("keymaps.fzf")

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

  -- Delete the buffer contents from the Neovim session
  map("n", "<leader>bd", bdelete, { desc = "Delete the buffer contents from the Neovim session" })

  -- Add a keymap to silently write the buffer contents to a file
  map("n", "<leader>w", "<CMD>silent write<CR>", { desc = "write buffer contents to file" })

  -- Some keymaps for LSP capabilities
  map("n", "gd", telescope.lsp_definitions, { desc = "Jump to the object definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to the object declaration" })
  map("n", "gT", telescope.lsp_type_definitions, { desc = "Get the type documentations" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Jump to the implementation" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Open the documentations of the object" })
  map("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "Get the help documentations" })
  map("n", "gr", vim.lsp.buf.rename, { desc = "Rename the object under the cursor" })
  map("n", "gR", telescope.lsp_references, { desc = "Jump to the reference of the object" })
  map("n", "gra", vim.lsp.buf.code_action, { desc = "Open available code actions" })
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
  map("n", "<leader>wl", vim.lsp.buf.list_workspace_folders, { desc = "List workspace folders" })
end

return M
