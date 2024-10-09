-- Module for configuring the "conform" plugin for formatting using LSP

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      javascript = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      scss = { "prettier" },
      sh = { "shfmt" },
      python = { "ruff_format" },
      typescript = { "prettier" },
      vue = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)

      -- Disable file formatting on any temporary buffer contents
      if bufname:match("/tmp/") then
        return
      else
        return {
          timeout_ms = 2500,
          lsp_fallback = true,
        }
      end
    end,
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
