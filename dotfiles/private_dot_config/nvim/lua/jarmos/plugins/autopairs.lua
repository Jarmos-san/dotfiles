--[[
Module for configuring the "autopairs.nvim" plugin.
--]]

local M = {}

function M.config()
  local npairs = require("nvim-autopairs")
  local rule = require("nvim-autopairs.rule")

  -- Configure the plugin to be based on Treesitter.
  npairs.setup({ check_ts = true })

  -- Configure the plugin to work on HTML/JSX files as well.
  npairs.add_rule(rule("<", ">"))
end

return M
