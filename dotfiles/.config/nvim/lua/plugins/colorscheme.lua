-- Module for installing & configuring some colorschemes

return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
    opts = { style = "night" },
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
    -- Disable this plugin, since it breaks with the recent introduction of Semantic Highlighting in Neovim v0.9
    disable = true,
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = true,
  },
}
