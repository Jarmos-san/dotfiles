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
  context_commentstring = { -- Enable Treesitter aware commenting for certain files like JSX/TSX
    enable = true,
    enable_autocmd = false,
  },
  highlight = { -- Enable syntax highlighting using the Treesitter parsers
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { -- Disable Treesitter-based indentation since its errorneous
    enable = false,
  },
  incremental_selection = { -- Incrementally select content powered by Treesitter
    enable = true,
  },
  autotag = { -- Enable adding automatic HTML/JSX closing tags based on Treesitter queries
    enable = true,
  },
  pairs = { -- Enable bracket pair highlighting
    enable = true,
    -- highlight_pair_events = { "CursorMoved" },
    highlight_pair_events = { "CursorMoved" },
  },
  textobjects = { -- syntax-aware textobjects
    select = {
      enable = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of function" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of function" },
        ["aC"] = { query = "@class.outer", desc = "Select outer part of class" },
        ["iC"] = { query = "@class.inner", desc = "Select inner part of class" },
        ["ac"] = { query = "@conditional.outer", desc = "Select outter part of if/else expression" },
        ["ic"] = { query = "@conditional.inner", desc = "Select inner part of if/else expression" },
        ["ab"] = { query = "@block.outer", desc = "Select outer part of a code block" },
        ["ib"] = { query = "@block.inner", desc = "Select inner part of a code block" },
        ["al"] = { query = "@loop.outer", desc = "Select around a loop statement" },
        ["il"] = { query = "@loop.inner", desc = "Select inside a loop statement" },
        -- TODO: Check out what they're supposed to be
        -- ["is"] = { query = "@statement.inner", desc = "Select inside a statement" },
        -- ["as"] ={ query = "@statement.outer", desc = "Select outside a statement" },
        -- ["am"] = "@call.outer",
        -- ["im"] = "@call.inner",
        ["ad"] = { query = "@comment.outer", desc = "Select around a comment line" },
        ["id"] = { query = "@comment.inner", desc = "Select inside a comment line" },
      },
    },
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Jump to the next function" },
        ["]C"] = { query = "@class.outer", desc = "Jump to the next class" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Jump to previous function" },
        ["[C"] = { query = "@class.outer", desc = "Jump to previous class" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>>"] = { query = "@parameter.inner", desc = "Swap inner parameters with successor" },
        ["<leader>f>"] = { query = "@function.outer", desc = "Swap outer function with successor" },
      },
      swap_previous = {
        ["<leader><"] = { query = "@parameter.inner", desc = "Swap inner parameters with predecessor" },
        ["<leader>f<"] = { query = "@function.outer", desc = "Swap outer parameters with predecessor" },
      },
    },
  },
}

M.setup = function()
  -- Load the configurations table from above to initialise the plugin with
  require("nvim-treesitter.configs").setup(configs)

  -- Configure MDX files to load the Markdown Treesitter parser
  vim.treesitter.language.register("markdown", "mdx")
end

return M
