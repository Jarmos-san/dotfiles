--[[
Module for configuring "telescope.nvim" plugin. More information is available at:
https://github.com/nvim-telescope/telescope.nvim
--]]

local M = {}

function M.config()
  local telescope = require("telescope")

  -- Configure Telescope to behave according to my personal needs.
  telescope.setup({
    defaults = {
      -- Ignore some unnecessary files/folder to reduce clutter
      file_ignore_patterns = { "node_modules", ".venv" },
    },
  })

  -- Load the many install Telescope extensions.
  telescope.load_extension("software-licenses")
end

return M
