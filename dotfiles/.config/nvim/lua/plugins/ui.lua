-- Module for configuring various UI enhancements to give Neovim a more modern look & feel

return {
  {
    "rcarriga/nvim-notify", -- Plugin for showing nice popup UI, can be used in conjunction with LSP & others
    event = { "VeryLazy" }, -- Ensure the plugin is loaded after entering the Neovim UI
    config = function()
      require("notify").setup({
        background_colour = "#262626", -- Set the background colour since the main Neovim background is transparent
        max_width = 60, -- Set the maximum width a notification bar can occupy so as to not clutter the screen too much
        max_height = 40, -- Set the maximum height for the notification message to occupy
        stages = "fade", -- Set the animation to something subtle to avoid distractions
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim", -- Plugin for quickly visualising Git VCS info right within the buffer
    event = { "VeryLazy" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    -- TODO: Experimental plugin to take Markdown notes
    -- "JellyApple102/flote.nvim", -- Plugin to take simple & disposable Markdown notes
  },

  {
    "norcalli/nvim-colorizer.lua", -- Plugin to showcase the color code based on Hex/RGB/HSL & more
    event = { "BufReadPost" },
    ft = { "typescriptreact", "typescript", "javascript", "javascriptreact", "scss", "css", "html" },
  },
}
