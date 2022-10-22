--[[
Module for configuring the "null-ls" plugin.
--]]

local M = {}

function M.config()
  local null_ls = require("null-ls")
  local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    on_attach = function(client, bufnr)
      -- Special logic which configure "null-ls" to format on save using the associated source(s).
      -- For more information on the same, refer to the wiki section available at:
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = lsp_format_augroup,
          buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = lsp_format_augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function()
                return client.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,

    sources = {
      null_ls.builtins.formatting.stylua, -- formatter for Lua code.
      null_ls.builtins.diagnostics.selene.with({ -- linter for Lua code.
        -- INFO: Load the "selene" linter only if its configuration file exists in the project directory.
        condition = function(utils)
          return utils.root_has_file({ "selene.toml", "vim.toml" })
        end,
      }),
      null_ls.builtins.diagnostics.eslint_d, -- A faster version of ESLint (linter for TS/JS code).
      null_ls.builtins.formatting.prettierd, -- A faster version of Prettier (formatter for TS/JS code).
      null_ls.builtins.formatting.black, -- formatter for Python code.
      null_ls.builtins.diagnostics.mypy, -- static type checker for Python code.
      null_ls.builtins.diagnostics.pydocstyle, -- linter for checking standard practices in Python code.
      null_ls.builtins.formatting.isort, -- import sorter for Python code.
      null_ls.builtins.diagnostics.flake8, -- linter for ensuring uniform coding practices in Python code.
    },
  })
end

return M
