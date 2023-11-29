-- Module for configuring the "mason" plugin for managing LSP servers

return {
  "williamboman/mason.nvim",
  cmd = { "LspInstall", "LspUninstall", "Mason" },
  opts = {
    -- Configure the plugin to have rounded borders
    ui = { border = "rounded" },

    -- Configure the log levels for the plugin
    log_level = vim.log.levels.WARN,

    -- LSP servers to ensure is always installed
    ensure_installed = {
      -- Some of the commented out LSP servers aren't available for download!
      "astro",
      "bashls",
      -- "black",
      -- "debugpy",
      "cssls",
      "dockerls",
      "eslint",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      -- "prettier",
      "pyright",
      "ruff_lsp",
      "rust_analyzer",
      -- "taplo", -- TODO: Figure out how to make it identify the "pyproject.toml" file
      -- "selene", -- FIXME: Broken on Ubuntu 20.04
      -- "shellcheck",
      -- "shfmt",
      -- "stylua",
      "stylelint_lsp",
      "sqlls",
      "tailwindcss",
      "tsserver",
      "typst_lsp",
      "vale_ls",
      "yamlls",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
  end,
  dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
}
