local M = {}

-- Alias to the API for setting the syntax highlights
local hl = vim.api.nvim_set_hl

-- Table of colours
local colours = {
  none = "none",
  grey = "#45413d",
  light_grey = "#6e6c69",
  white = "#ffffff",
  black = "#000000",
  blue = "blue",
}

M.load = function()
  -- Clear any syntax highlighting (if any) that exists
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end

  -- Set some basic configuration options for Neovim
  vim.g.colors_name = "tansai"
  vim.o.termguicolors = true
  vim.o.background = "dark"

  -- Basic highlighting unrelated to code (or syntax) highlights
  hl(0, "Normal", { bg = colours.none, fg = colours.none })
  hl(0, "NonText", { bg = colours.none, fg = colours.none })
  hl(0, "CursorLine", { bg = colours.grey, fg = colours.none })
  hl(0, "CursorLineNr", { bg = colours.grey, fg = colours.white })
  hl(0, "LineNr", { bg = colours.none, fg = colours.grey })
  hl(0, "Comment", { bg = colours.none, fg = colours.light_grey })
end

return M
