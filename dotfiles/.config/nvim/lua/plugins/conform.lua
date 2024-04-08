-- Module for configuring the "conform" plugin for formatting using LSP

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "ruff_format" },
      typescript = { "prettier" },
      vue = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    local conform = require("conform")

    -- Setup "conform.nvim" to work
    conform.setup(opts)

    -- Customise the default "prettier" command to format Markdown files as well
    conform.formatters.prettier = {
      prepend_args = { "--prose-wrap", "always" },
    }

    -- Add proper indents to the formatted Shell files
    conform.formatters.shfmt = {
      prepend_args = {
        "--indent=2",
        "--binary-next-line",
        "--case-indent",
        "--space-redirects",
        "--keep-padding",
      },
    }
  end,
  dependencies = { "neovim/nvim-lspconfig" },
}
