--[[
Module for configuring the "mini.nvim" plugin

Find more documentation details at the following url:
https://github.com/echasnovski/mini.nvim
--]]

local M = {}

function M.config()
    require("mini.statusline").setup()
end

return M
