-- Module for configuring the LSP capabilities of Neovim

return {
  {
    -- Official plugin for more ease in configuring the in-built LSP client.
    "neovim/nvim-lspconfig",
    -- event = "BufReadPost", -- Lazy-load the plugin only after the Neovim UI is loaded.
    config = function() -- Configurations for the many LSP servers used within Neovim.
      require("configs.lsp")
    end,
    dependencies = {
      -- This plugin needs to be loaded as well otherwise Neovim can't find the LSP binary on $PATH.
      "williamboman/mason.nvim",
    },
  },

  {
    -- Plugin for VSCode-like snippets powered by Neovim's in-built LSP.
    "L3MON4D3/LuaSnip",
    event = "InsertEnter", -- Lazy-load the plugin only when the buffer is in Insert mode.
    dependencies = { -- Load these dependencies when the snippet plugin is used.
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "rafamadriz/friendly-snippets",
    },
  },

  {
    -- Extra plugin for a more VSCode-like snippets behaviour.
    "rafamadriz/friendly-snippets",
    event = "InsertEnter", -- Lazy-load the plugin only when the buffer is in an Insert mode.
  },

  {
    -- Better autocompletion support for Neovim.
    "hrsh7th/nvim-cmp",
    dependencies = { -- A bunch of extra extensions for the autocompletions plugin.
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() -- Configuration module for the autocompletion module.
      require("configs.cmp")
    end,
    event = "InsertEnter", -- Lazy-load the plugin only when the buffer is in Insert mode.
  },

  {
    -- Plugin for using the builtin LSP client to hook into other non-LSP tools like Prettier & ESLint.
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPost", -- Load the plugin only when the buffer is read & filetype is known.
    dependencies = { -- Load some necessary dependencies for the plugin.
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function() -- Configuration module for the plugin.
      require("configs.null-ls")
    end,
  },
}
