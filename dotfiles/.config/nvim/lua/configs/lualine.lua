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
        "dashboard",
        "filesytem",
        "mason",
        "neo-tree",
        "neo-tree-popup",
        "null-ls-info",
        "lazy",
        "lspinfo",
        "starter",
        "TelescopePrompt",
      },
    },
  }

  local sections = {
    -- Statusline components to showcase on the right-most end
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
    lualine_c = { -- INFO: This section shows the entire filepath relative to the project root
      { "filename", path = 1 },
    },
  }

  require("lualine").setup({ options = options, sections = sections })
end

return M
