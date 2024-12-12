return {
  "folke/tokyonight.nvim",
  event = "VimEnter",
  opts = {
    style = "night",
    light_style = "night",
    transparent = true,
    terminal_colors = true,
    dim_inactive = true,
    lualine_bold = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VimEnter",
    config = true,
    opts = {},
  },
  {
    "comfysage/evergarden",
    priority = 1000,
    opts = {
      transparent_background = true,
      contrast_dark = "medium",
    },
    config = true,
  },
}
