--[[
Module for configuring the "mason.nvim" plugin.

The plugin is used for installing LSP servers, formatters, linters & so on
more easily from within Neovim (or automatically).
--]]

local M = {}

-- Basic configuration for the "mason.nvim" plugin
function M.config()
  local mason = require("mason")

  mason.setup({
    -- Necessary Neovim settings to debug the "mason.nvim" plugin
    -- better with extra information.
    log_level = vim.log.levels.DEBUG,
  })
end

-- "mason.nvim" plugin which auto-installs the necessary tools
-- like LSP servers, linters, formatters & so on.
function M.install_servers()
  local installer = require("mason-tool-installer")

  -- Following are the list of servers which will be auto-installed
  -- as a must've after the core "mason.nvim" plugin ins installed.
  installer.setup({
    ensure_installed = {
      "lua-language-server", -- Lua LSP server.
      "bash-language-server", -- Bash LSP server.
      "black", -- Formatter for Python.
      "dockerfile-language-server", -- Docker LSP server.
      "editorconfig-checker", -- Tool to check EditorConfig inconsistencies.
      "eslint_d", -- Faster version of ESLint.
      "flake8", -- Tool to check for the coding standards inconsistencies.
      "isort", -- Python formatter for sorting imports.
      "json-lsp", -- JSON LSP server.
      "mypy", -- Static Checker for Python code.
      "prettierd", -- Faster version of Prettier.
      "pydocstyle", -- Tool to check for inconsistencies in Python docstrings.
      "pyright", -- Python LSP server.
      "selene", -- Linter for Lua code.
      "shellcheck", -- Linter for Bash scripts.
      "stylua", -- Formatter for Lua code.
      "taplo", -- TOML LSP server.
      "texlab", -- LaTeX LSP server.
      "typescript-language-server", -- TypeScript LSP server.
      "vale", -- Linting tool to check for grammatical inconsistencies in prose content.
      "yaml-language-server", -- YAML LSP server.
      "yamllint", -- Linter for YAML files.
    },
  })
end

return M
