-- Module of keymaps & bindings which makes using Neovim a pleasure

local M = {}

M.setup = function()
  require("keymaps.core")
  require("keymaps.terminal")

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
  local git_files = function()
    if utils.is_git_repo() or utils.has_git_dir() then
      telescope.git_files()
    end
  end

  -- List all available files (and directories) using Telescope
  map("n", "<leader>ff", telescope.find_files, { desc = "List all available files/directories" })
  map("n", "<leader>gf", git_files, { desc = "List all files and folders tracked inside the Git repository" })
  map("n", "<leader>of", telescope.oldfiles, { desc = "Open recently opened files" })

  -- Delete the buffer contents from the Neovim session
  map("n", "<leader>bd", bdelete, { desc = "Delete the buffer contents from the Neovim session" })

  -- List all currently loaded buffers
  map("n", "<leader>b", telescope.buffers, { desc = "List all currently in-memory loaded buffers" })

  -- Visually list in Telescope all the currently registered marks on the current buffer
  map("n", "<leader>m", telescope.marks, { desc = "List all Vim marks registered on the current buffer" })

  -- List all the registers available on the buffer
  map("n", "<leader>r", telescope.registers, { desc = "Show the contents of the registers" })

  -- Open Telescope to fuzzy search through the help docs
  map("n", "<leader>h", telescope.help_tags, { desc = "Open the help tags menu" })

  -- Grep through the contents of the current directory for a particular string pattern
  map("n", "<leader>lg", telescope.live_grep, { desc = "Perform a grep on the file contents of the current directory" })

  -- Open a list of keymaps which can be fuzzy-searched using the Telescope UI
  map("n", "<leader>k", telescope.keymaps, { desc = "Open a list of available keymaps" })

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
