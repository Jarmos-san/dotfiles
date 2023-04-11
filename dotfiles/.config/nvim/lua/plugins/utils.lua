-- Module for configuring some utilitarian plugins

-- Table of options for configuring the "smartcolumn" plugin
local smartcolumn_options = {
  disable_filetypes = {
    "help",
    "text",
    "markdown",
    "alpha",
    "checkhealth",
    "Trouble",
    "toml",
    "zsh",
    "gitignore",
    "sh",
    "json",
    "tmux",
    "gitattributes",
  },
  custom_colorcolumn = { lua = 120, dockerfile = 120, python = 88, yaml = 90, markdown = 80 },
}

return {
  { "famiu/bufdelete.nvim" }, -- Plugin for deleting & removing buffers without messing up the window layout

  { "max397574/better-escape.nvim", event = "BufReadPost" }, -- Plugin for a better & quicker "Escape" mechanism.

  {
    "karb94/neoscroll.nvim", -- Plugin to enable a smoother scroll animation
    event = "BufReadPost", -- Load the plugin only after the contents of the buffer are read
    config = function()
      require("neoscroll").setup() -- Initialising the plugin with default configs is necessary for it work everytime
    end,
  },

  {
    "m4xshen/smartcolumn.nvim", -- Functionally better plugin for showing a nice colorcolum
    event = "FileType", -- Load the plugin only when the filetype of the buffer is recognised.
    opts = {
      -- Disable the colorcolum in certain filetypes like Vim help files.
      disabled_filetypes = smartcolumn_options.disable_filetypes,
      -- Configure the character length at which to show the colorcolumn.
      custom_colorcolumn = smartcolumn_options.custom_colorcolumn,
    },
  },

  {
    "norcalli/nvim-colorizer.lua", -- Plugin to display the colours of their respective hex codes.
    event = { "BufReadPost" },
    ft = { "scss", "css", "javascript", "typescriptreact", "html" }, -- Specific filetypes to load this plugin for.
  },

  {
    "b0o/schemastore.nvim", -- Plugin to load JSON schemas
    event = { "BufReadPost" },
    ft = "json",
  },

  {
    -- TODO: Might replace it with the "rebelot/terminal.nvim" plugin
    "akinsho/toggleterm.nvim", -- Plugin for a better more accessible terminal
    event = { "VeryLazy" }, -- Load the plugin only afer reading the contents of the buffer
    config = true, -- Initialise the plugin with default values
  },

  {
    "chrisgrieser/nvim-various-textobjs", -- Plugin which provides some extra keybinds for easier navigation
    event = { "BufReadPost" },
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true }) -- use plugin provided default inbuilt keymaps
    end,
  },

  {
    "simrat39/rust-tools.nvim", -- Plugin for better Rust LSP support & more
    event = { "BufReadPost" },
    ft = "rust", -- Load the plugin only when working on Rust files
  },

  {
    "jose-elias-alvarez/typescript.nvim", -- Plugin for better TypeScript LSP support & more
    event = { "BufReadPost" },
    ft = { "typescript", "typescriptreact" }, -- Load the plugin only when working on TypeScript projects
  },

  {
    "windwp/nvim-ts-autotag", -- Plugin to automatically insert HTML/JSX tags where necessary
    event = { "BufReadPost" },
    ft = { "typescriptreact", "javascriptreact", "html" },
  },
}
