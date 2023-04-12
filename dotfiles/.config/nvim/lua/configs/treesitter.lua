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
  -- INFO: This is a stupid hack until the colorscheme plugin I use supports semantic highligting as well.
  -- See this issue thread to keep track of semantic highlighting on the "navarasu/onedark.nvim" colorscheme;
  -- https://github.com/navarasu/onedark.nvim

  -- See this Reddit discussion for more information on the same:
  -- https://www.reddit.com/r/neovim/comments/12gvms4/this_is_why_your_higlights_look_different_in_90
  local links = {
    ["@lsp.type.namespace"] = "@namespace",
    ["@lsp.type.type"] = "@type",
    ["@lsp.type.class"] = "@type",
    ["@lsp.type.enum"] = "@type",
    ["@lsp.type.interface"] = "@type",
    ["@lsp.type.struct"] = "@structure",
    ["@lsp.type.parameter"] = "@parameter",
    ["@lsp.type.variable"] = "@variable",
    ["@lsp.type.property"] = "@property",
    ["@lsp.type.enumMember"] = "@constant",
    ["@lsp.type.function"] = "@function",
    ["@lsp.type.method"] = "@method",
    ["@lsp.type.macro"] = "@macro",
    ["@lsp.type.decorator"] = "@function",
  }

  for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
  end
end

return M
