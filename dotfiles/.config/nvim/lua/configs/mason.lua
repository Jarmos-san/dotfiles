-- Module for configuring the "mason.nvim" plugin

local M = {}

M.config = function()
  -- The list of LSP servers to install
  local mason_packages = {
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
  }

  -- Configure the Mason UI to look nicer and distinct from its surroundings
  require("mason").setup({
    -- Configure the plugin to have rounded borders
    ui = { border = "rounded" },

    -- Configure the log levels for the plugin
    log_level = vim.log.levels.WARN,
  })

  -- Configure Mason to automatically install certain LSP servers
  -- NOTE: This plugin can ONLY install LSP servers and nothing else. In other words, DAPs, formatters, linters needs
  -- to be either installed either manually or I need to write custom code to make Mason do it for me
  require("mason-lspconfig").setup({
    -- Configure Mason to install the necessary LSP servers automatically
    ensure_installed = mason_packages,
  })

  -- TODO: Write code to make Mason install everything related to LSP automatically and "properly"
  -- vim.cmd(":MasonInstall stylua")
end

return M
