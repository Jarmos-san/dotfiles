--[[
Module for configuring the LSP diagnostics plugin.
--]]

local M = {}

function M.config()
  require("trouble").setup()
end

return M
