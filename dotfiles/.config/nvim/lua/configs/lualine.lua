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
        "alpha",
        "dashboard",
        "filesytem",
        "mason",
        "neo-tree",
        "neo-tree-popup",
        "null-ls-info",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
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
