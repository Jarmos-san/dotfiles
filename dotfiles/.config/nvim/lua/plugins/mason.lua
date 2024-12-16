-- Module for configuring the "mason" plugin for managing LSP servers

return {
  {
    "williamboman/mason.nvim",
    cmd = { "LspInstall", "LspUninstall", "Mason" },
    opts = {
      -- Configure the plugin to have rounded borders
      ui = { border = "rounded" },

      -- Configure the log levels for the plugin
      log_level = vim.log.levels.WARN,
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    opts = {
      ensure_installed = {
        "astro-language-server",
        "ansible-language-server",
        "ansible-lint",
        "bash-language-server",
        "black",
        "css-lsp",
        "debugpy",
        "dockerfile-language-server",
        "eslint-lsp",
        "goimports",
        "golines",
        "gopls",
        "hadolint",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "mypy",
        "prettier",
        "pyright",
        "ruff",
        -- "taplo", -- TODO: Figure out how to make it identify the "pyproject.toml" file
        "selene", -- FIXME: Broken on Ubuntu 20.04
        "shellcheck",
        "shfmt",
        "stylua",
        "stylelint",
        "sqlls",
        "tailwindcss-language-server",
        "terraform-ls",
        "typescript-language-server",
        "typst-lsp",
        "vale-ls",
        "vue-language-server",
        "yaml-language-server",
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
}
