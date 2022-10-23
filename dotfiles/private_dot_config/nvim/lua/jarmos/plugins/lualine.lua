--[[
Module for configuring the statusline using the "lualine" plugin.
https://github.com/nvim-lualine/lualine.nvim
--]]

local M = {}

function M.config()
  local lualine = require("lualine")

  lualine.setup({
    options = {
      theme = "onedark",
    },
    disabled_filetypes = {
      "packer",
      "filesystem",
      "neo-tree",
    },
  })
end

return M
