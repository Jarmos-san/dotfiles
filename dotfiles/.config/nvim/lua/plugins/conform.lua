-- Module for configuring the "conform" plugin for formatting using LSP

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
  dependencies = { "neovim/nvim-lspconfig" },
}
