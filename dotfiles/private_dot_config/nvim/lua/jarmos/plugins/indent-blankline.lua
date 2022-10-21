--[[
Module for configuring the plugin which visualises the indents & blanklines.
https://github.com/lukas-reineke/indent-blankline.nvim
--]]

local M = {}

function M.config()
  local indent_blankline = require("indent_blankline")

  indent_blankline.setup({
    char = "┊",
    show_trailing_blankline_indent = true,
    show_current_context = true,
    show_current_context_start = true,
  })
end

return M
