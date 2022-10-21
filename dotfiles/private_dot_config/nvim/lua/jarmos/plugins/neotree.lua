--[[
Module for configuring the file-explorer plugin
https://github.com/nvim-neo-tree/neo-tree.nvim
--]]

local M = {}

function M.config()
  local neotree = require("neo-tree")

  neotree.setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      position = "left",
      width = "25",
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
    },
  })
end

return M
