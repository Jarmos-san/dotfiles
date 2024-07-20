return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- Enable Neovim to wait a couple of milliseconds after a key is pressed to trigger the plugin
    vim.o.timeout = true

    -- Configure a high enough timeout length so that the plugin does not trigger all the time
    vim.o.timeoutlen = 500
  end,
  config = function()
    require("which-key").setup({
      presets = "modern",
      win = {
        border = "single",
      },
    })
  end,
}
