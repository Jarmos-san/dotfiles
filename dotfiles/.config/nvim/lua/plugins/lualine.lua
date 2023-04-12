-- Module for configuring the statusline with the "lualine.nvim" plugin

local sections = {
  -- Statusline components to showcase on the right-most end
  lualine_x = { "filetype" },
  lualine_y = { "progress" },
  lualine_z = { "location" },
}

local options = {
  -- Leaving an empty table renders the square-edged components, else the default angled ones are loaded
  section_separators = {},
  component_separator = "|",
  theme = "catppuccin", -- Set the theme
  globalstatus = true,
  disabled_filetypes = { -- Disable the statusline for certain filetypes mentioned below
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

local config = function()
  require("lualine").setup({ options = options, sections = sections })
end

return {
  {
    "nvim-lualine/lualine.nvim", -- Plugin for configuring a nice looking statusline
    event = "VeryLazy", -- Load the plugin when Lazy wants it to
    config = config,
  },
}
