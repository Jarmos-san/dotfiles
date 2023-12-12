-- Module for configuring the "conform" plugin for formatting using LSP

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      terraform_fmt = { "terraform", "terraform-vars" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
  dependencies = { "neovim/nvim-lspconfig" },
}
