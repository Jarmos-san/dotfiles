-- Module for configuring the Telescope plugin

return {
  "nvim-telescope/telescope.nvim",
  event = "BufRead",
  cmd = "Telescope",
  opts = {
    defaults = {
      file_ignore_patterns = { "^%.git$", "node_modules", "^%.?venv$", "^%.?env$" },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
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
