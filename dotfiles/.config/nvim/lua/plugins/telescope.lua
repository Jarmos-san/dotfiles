-- Module for configuring the Telescope plugin

return {
  "nvim-telescope/telescope.nvim",
  event = "BufRead",
  cmd = "Telescope",
  opts = {
    defaults = {
      file_ignore_patterns = {
        "%.git",
        "node_modules",
        "%.venv",
        "^%.?env$",
        "%.terraform",
        "%.mypy_cache",
        "%.ruff_cache",
        "%.nuxt",
        "%.task",
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--no-ignore" },
        -- TODO: Figure a way out to make vertical splits through Telescope
        -- mappings = {
        --   i = {
        --     ["<CR>"] = function(bufnr)
        --       if vim.bo[0].filetype ~= "ministarter" then
        --         require("telescope.actions").select_vertical(bufnr)
        --       end
        --     end,
        --   },
        -- },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
  end,
  dependencies = {
    "devicons",
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
}
