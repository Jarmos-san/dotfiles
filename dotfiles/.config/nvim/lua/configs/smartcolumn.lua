-- Module for configuring the "m4xshen/smartcolumn.nvim" plugin.

local M = {}

-- List of filetypes where the colour column should be disabled for readability concerns.
M.disable_filetypes = {
  "alpha",
  "checkhealth",
  "gitattributes",
  "gitconfig",
  "gitignore",
  "help",
  "json",
  "markdown",
  "mason",
  "lazy",
  "lspinfo",
  "sh",
  "text",
  "Trouble",
  "tmux",
  "toml",
  "zsh",
}

-- List of filtypes & their specific column width at which the colour column should be shown.
M.filetype_column_width = {
  lua = 120,
  dockerfile = 120,
  python = 88,
  yaml = 90,
  markdown = 80,
  typescriptreact = 81,
}

return M
