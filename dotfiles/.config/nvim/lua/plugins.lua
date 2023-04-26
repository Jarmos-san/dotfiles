-- Module which lazy.nvim automatically uses to manage the Neovim plugins.
-- Its does not need to be manually reloaded nor sourced. See the docs below for more information on this regards:
-- https://github.com/folke/lazy.nvim#-structuring-your-plugins

-- TODO: Move all the plugins from the "lua/plugins" folder over here instead

-- TODO: Plugins to add later on
-- 1. "rebelot/terminal.nvim"

-- Module containing configuration options for the colour column plugin ("m4xshen/smartcolumn.nvim")
local smartcolumn_options = require("configs.smartcolumn")

local plugins = {
  {
    -- Plugin for deleting & removing buffers without messing up the window layout
    "famiu/bufdelete.nvim",
    -- Load the plugin right before the current buffer is about to be deleted.
    event = "BufDelete",
  },

  {
    -- Plugin for a better & quicker "Escape" mechanism.
    "max397574/better-escape.nvim",
    -- Load the plugin right before leaving Insert mode.
    event = "InsertLeavePre",
  },

  {
    -- Plugin to enable a smoother scroll animation
    "karb94/neoscroll.nvim",
    -- Load the plugin only after the contents of the buffer are read.
    event = "BufRead",
    -- Initialise the plugin with some configurations
    opts = {
      -- Respect the scrolloff marging (see ":h scrolloff" for more info)
      respect_scrolloff = true,
      -- Stop the cursor from scrolling further if the window cannot scroll any more.
      cursor_scrolls_alone = false,
    },
  },

  {
    -- Functionally better plugin for showing a nice colorcolum
    "m4xshen/smartcolumn.nvim",
    -- Load the plugin only when the filetype of the buffer is recognised.
    event = "FileType",
    -- Initialise the plugin with some configurations for easier readability & usability
    opts = {
      -- Disable the colorcolum in certain filetypes like vimdoc & certain configuration files.
      disabled_filetypes = smartcolumn_options.disable_filetypes,
      -- Configure the character length at which to show the colorcolumn.
      custom_colorcolumn = smartcolumn_options.filetype_column_width,
    },
  },
}

return plugins
