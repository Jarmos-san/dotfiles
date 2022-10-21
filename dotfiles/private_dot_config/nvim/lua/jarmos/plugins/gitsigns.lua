--[[
Module for configuring the plugin which handles version-control features
using Git. For more information on this plugin refer to the repository at:
https://github.com/lewis6991/gitsigns.nvim
--]]

local M = {}

function M.config()
  require("gitsigns").setup()
end

return M
