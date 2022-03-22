--[[
Module for configuring "lewis6991/gitsigns".

For more info on configuring this plugin, refer to the docs at ":h gitsigns"
--]]

local M = {}

function M.setup() end

function M.config()
    require("gitsigns").setup()
end

return M
