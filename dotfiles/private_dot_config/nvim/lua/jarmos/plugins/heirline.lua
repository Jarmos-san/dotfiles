--[[
Module for configuring the statusline plugin.
--]]

-- local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
-- local colors = require("onedark.colors")

local M = {}

function M.config()
  local statusline = {}
  require("heirline").setup(statusline)
end

return M
