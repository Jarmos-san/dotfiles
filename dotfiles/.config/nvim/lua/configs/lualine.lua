-- Module for configuring the Lualine plugin (the statusline)

local M = {}

M.config = function()
  local options = {
    -- Leaving an empty table renders the square-edged components, else the default angled ones are loaded
    section_separators = {},
    component_separator = "|",
    theme = "onedark",
    globalstatus = true,
    disabled_filetypes = {
      statusline = {
        "filesytem",
        "neo-tree",
        "dashboard",
        "lazy",
        "alpha",
        "null-ls-info",
        "lspinfo",
        "mason",
        "neo-tree-popup",
      },
    },
  }

  local sections = {
    -- Statusline components to showcase on the right-most end
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  }

  require("lualine").setup({ options = options, sections = sections })
end

return M
