-- Module for configuring the "which-key" plugin

local M = {}

M.init = function()
  -- Enable Neovim to wait a couple of milliseconds after a key is pressed to trigger the plugin
  vim.o.timeout = true

  -- Configure a high enough timeout length so that the plugin does not trigger all the time
  vim.o.timeoutlen = 500
end

M.config = function()
  require("which-key").setup({
    plugins = {
      -- Disable the "spelling" plugin since it can be annoying at times
      spelling = { enabled = false },
    },

    -- Configure the floating window to have a window for clearly distinguishing between which is what
    window = { border = "single" },

    -- Disable showing keymaps w/o any descriptions to avoid unnecessary clutter
    ignore_missing = true,
  })
end

return M
