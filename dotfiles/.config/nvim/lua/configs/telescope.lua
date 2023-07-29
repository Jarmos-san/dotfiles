-- Module for configuring the "telescope.nvim" plugin

local M = {}

M.configs = {
  defaults = {
    file_ignore_patterns = { "%.git", "node_modules", "venv", ".venv", "env", ".env" },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
}

return M
