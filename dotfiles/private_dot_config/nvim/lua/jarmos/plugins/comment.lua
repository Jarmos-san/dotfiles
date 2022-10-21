--[[
Module for configuring the "Comment.nvim" plugin.
https://github.com/numToStr/Comment.nvim
--]]

local M = {}

function M.config()
  local commentstring_integrations = require("ts_context_commentstring.integrations.comment_nvim")

  require("Comment").setup({
    -- The only necessary configurations for commenting to work well in JSX/TSX files.
    pre_hook = commentstring_integrations.create_pre_hook(),
  })
end

return M
