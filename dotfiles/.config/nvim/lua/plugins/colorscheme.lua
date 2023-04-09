-- Module for installing & configuring some colorschemes

return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
    opts = { style = "moon" },
  },

  {
    "catppuccin/nvim",
    name = "catpuccin",
    lazy = true,
  },

  {
    "navarasu/onedark.nvim", -- The default colorscheme used right now
    name = "onedark",
    lazy = true,
    opts = {
      style = "darker",
      transparent = true,
      lualine = { transparent = true },
    },
    event = "VimEnter",
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = true,
  },
}
