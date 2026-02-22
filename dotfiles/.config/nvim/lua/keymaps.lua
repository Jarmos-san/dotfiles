-- Module of keymaps & bindings which makes using Neovim a pleasure

local telescope = require("telescope.builtin")
local utils = require("utils")
local map = require("utils").map
local terminal = require("terminal").setup

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

-- Change to Normal mode by pressing "jk" in quick succession
map("i", "jk", "<esc>", { desc = "Change to Normal mode" })

-- Easier navigation to the beginning or the start of the line
map("n", "H", "<Home>", { desc = "Move to the beginning of the line" })
map("n", "L", "<End>", { desc = "Move to the end of the line" })

-- Resize windows using <Ctrl + Arrow keys>
map("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Increase window width" })

-- Better & easier indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Disable the redundant (and sometimes annoying "Ex mode")
-- INFO: See the docs at ":h gQ" for more info on what its supposed to do
map("n", "gQ", "<NOP>")

-- Easier navigation in Insert mode without the arrow keys!
map("i", "<M-h>", "<Left>", { desc = "Move left in Insert mode" })
map("i", "<M-j>", "<Down>", { desc = "Move down in Insert mode" })
map("i", "<M-k>", "<Up>", { desc = "Move up in Insert mode" })
map("i", "<M-l>", "<Right>", { desc = "Move right in Insert mode" })

-- List all available files (and directories) using Telescope
map("n", "<leader>ff", telescope.find_files, { desc = "List all available files/directories" })
map("n", "<leader>gf", git_files, { desc = "List all files and folders tracked inside the Git repository" })
map("n", "<leader>of", telescope.oldfiles, { desc = "Open recently opened files" })

-- Delete the buffer contents from the Neovim session
map("n", "<leader>bd", bdelete, { desc = "Delete the buffer contents from the Neovim session" })

-- List all currently loaded buffers
map("n", "<leader>b", telescope.buffers, { desc = "List all currently in-memory loaded buffers" })

-- Navigate easier around buffers while using the "leader" key
map("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Change to the next buffer" })
map("n", "<leader>bp", "<CMD>bprevious<CR>", { desc = "Change to the previous buffer" })

-- Visually list in Telescope all the currently registered marks on the current buffer
map("n", "<leader>m", telescope.marks, { desc = "List all Vim marks registered on the current buffer" })

-- List all the registers available on the buffer
map("n", "<leader>r", telescope.registers, { desc = "Show the contents of the registers" })

-- Open Telescope to fuzzy search through the help docs
map("n", "<leader>h", telescope.help_tags, { desc = "Open the help tags menu" })

-- Grep through the contents of the current directory for a particular string pattern
map("n", "<leader>lg", telescope.live_grep, { desc = "Perform a grep on the file contents of the current directory" })

-- Open a Terminal inside Neovim itself
map("n", "<leader>t", terminal.float, { desc = "Open the terminal prompt in a horizontal split" })
map("n", "<leader>tv", terminal.vertical, { desc = "Open the terminal prompt in vertical split" })
map({ "n", "i" }, "<C-t>", terminal.toggle, { desc = "Toggle a floating terminal open/close" })

-- Exit terminal mode in builtin terminal with an easier to use shortcut
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
