--[[
Module for configuring the file-explorer plugin
https://github.com/nvim-neo-tree/neo-tree.nvim
--]]

local M = {}

function M.config()
  local neotree = require("neo-tree")

  vim.fn.sign_define("DiagnosticSignError", {
    text = " ",
    texthl = "DiagnosticSignError",
  })
  vim.fn.sign_define("DiagnosticSignWarn", {
    text = " ",
    texthl = "DiagnosticSignWarn",
  })
  vim.fn.sign_define("DiagnosticSignInfo", {
    text = " ",
    texthl = "DiagnosticSignInfo",
  })
  vim.fn.sign_define("DiagnosticSignHint", {
    text = " ",
    texthl = "DiagnosticSignHint",
  })

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
    git_status = {
      symbols = {
        deleted = "✖",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  })
end

return M
