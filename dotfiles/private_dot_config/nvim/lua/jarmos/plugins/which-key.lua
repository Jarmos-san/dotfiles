--[[
Module for configuring the "which-key" plugin.
--]]

local M = {}

function M.config()
  require("which-key").setup({
    window = {
      border = "double",
      winblend = 5,
    },
  })
end

return M
