-- Module for configuring the "notify" plugin

local M = {}

M.init = function()
  -- Set Neovim to use 24-bit colours
  vim.opt.termguicolors = true

  -- Set various other Neovim features to use the "notify" plugin instead
  vim.notify = require("notify")
end

M.options = {
  -- Configure the plugin to fade in/out w/o distractions
  stages = "fade",

  -- Add a "transparent" background to stop the plugin from complaining too much
  background_colour = "#000000",
}

return M
