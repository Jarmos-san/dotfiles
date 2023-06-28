-- Module for configuring the "m4xshen/smartcolumn.nvim" plugin.

local M = {}

-- List of filetypes where the colour column should be disabled for readability concerns.
local disable_filetypes = {
  "alpha",
  "checkhealth",
  "gitattributes",
  "gitconfig",
  "gitignore",
  "help",
  "json",
  "markdown",
  "mason",
  "mdx",
  "lazy",
  "lspinfo",
  "sh",
  "starter",
  "text",
  "Trouble",
  "tmux",
  "toml",
  "zsh",
}

-- List of filtypes & their specific column width at which the colour column should be shown.
local filetype_column_width = {
  lua = 120,
  dockerfile = 120,
  python = 88,
  yaml = 90,
  markdown = 80,
  typescriptreact = 81,
  rust = 100,
}

M.options = {
  -- Disable the colorcolum in certain filetypes like vimdoc & certain configuration files.
  disabled_filetypes = disable_filetypes,
  -- Configure the character length at which to show the colorcolumn.
  custom_colorcolumn = filetype_column_width,
}

return M
