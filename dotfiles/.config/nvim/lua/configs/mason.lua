local M = {}

local mason_packages = {
  "bash-language-server",
  "black",
  "debugpy",
  "dockerfile-language-server",
  "eslint_d",
  "json-lsp",
  "lua-language-server",
  "mypy",
  "prettier",
  "pyright",
  "ruff",
  -- "taplo", -- TODO: Figure out how to make it identify the "pyproject.toml" file
  -- "selene", -- FIXME: Broken on Ubuntu 20.04
  "shellcheck",
  "shfmt",
  "stylua",
  "tailwindcss-language-server",
  "typescript-language-server",
  "rust-analyzer",
  "rustfmt",
  "vale",
  "yaml-language-server",
}

M.setup = function()
  require("mason").setup({
    ui = { border = "rounded" },
    log_level = vim.log.levels.WARN,
  })
end

M.installer = function()
  require("mason-tool-installer").setup({
    ensure_installed = mason_packages,
    auto_update = true,
  })
end

return M
