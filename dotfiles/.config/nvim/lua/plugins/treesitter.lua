-- Module for configuring the in-built Treesitter capabilities

return {
  {
    "nvim-treesitter/nvim-treesitter", -- Plugin for better syntax highlighting & much more!
    build = function() -- Command to invoke after installing the plugin.
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    event = { "BufReadPost", "BufNewFile" }, -- Lazy-load the plugin only on certain events
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor", -- Rename stuff with the power of Treesitter!
      "JoosepAlviste/nvim-ts-context-commentstring", -- Plugin for better commenting on JSX/TSX files.
      "mrjones2014/nvim-ts-rainbow", -- Extension of bracket colours.
      "windwp/nvim-ts-autotag", -- Extension for automatic HTML tag completion.
      "nvim-treesitter/nvim-treesitter-textobjects", -- Navigate around code blocks more easily with this extension.
      "nvim-treesitter/playground", -- Extension for visualising the Treesitter nodes & graph.
    },
    opts = {
      -- Ensure the parsers for these languages are compulsarily installed
      ensure_installed = {
        "bash",
        "lua",
        "help",
        "json",
        "comment",
        "regex",
        "markdown",
        "markdown_inline",
        "diff",
        "dockerfile",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "javascript",
        "make",
        "python",
        "regex",
        "rst",
        "rust",
        "scss",
        "tsx",
        "toml",
        "typescript",
        "yaml",
        "vim",
      },
      highlight = { -- Enable syntax highlighting using the Treesitter parsers
        enable = true,
      },
      indent = { -- Disable Treesitter-based indentation since its errorneous
        enable = false,
      },
      context_commentstring = {
        -- Enable easier commenting using Treesitter
        enable = true,
        enable_autocmd = false,
      },
      incremental_selection = { -- Incrementally select content powered by Treesitter
        enable = true,
      },
      autotag = { -- Enable adding automatic HTML/JSX closing tags based on Treesitter queries
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts) -- Load the plugin with the config values mentioned above
    end,
  },
}
