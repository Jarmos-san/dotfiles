--[[
Module for configuring the "onedark.nvim" plugin.

This plugin is used for customising the Neovim colour scheme.
--]]

local M = {}

function M.config()
  local onedark = require("onedark")

  -- Configure exactly how the colorscheme looks & behaves like over here.
  -- More configuration information are available at:
  -- https://github.com/navarasu/onedark.nvim#default-configuration
  onedark.setup({
    style = "deep",
  })

  onedark.load()
end

return M
