-- Module for configuring some utilitarian plugins

return {
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
