--[[
Module for configuring "telescope.nvim" plugin. More information is available at:
https://github.com/nvim-telescope/telescope.nvim
--]]

local M = {}

function M.config()
  local telescope = require("telescope")

  telescope.load_extension("software-licenses")
end

return M
