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
    event = "ColorSchemePre",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        -- dim_inactive = { enabled = true, shade = "dark", percentage = 0.9 },
        integrations = { notify = true },
      })
    end,
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
