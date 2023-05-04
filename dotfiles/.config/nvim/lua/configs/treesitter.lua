-- Module configuring the Treesitter capabilities of Neovim

local M = {}

local configs = {
  -- Ensure the parsers for these languages are compulsarily installed
  ensure_installed = {
    "bash",
    "comment",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
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
    "vimdoc",
  },
  highlight = { -- Enable syntax highlighting using the Treesitter parsers
    enable = true,
    additional_vim_regex_highlighting = false,
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
}

M.setup = function()
  require("nvim-treesitter.configs").setup(configs)
end

return M
