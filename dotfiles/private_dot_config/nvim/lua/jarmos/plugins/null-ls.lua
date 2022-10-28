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
              timeout_ms = 6000,
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
      null_ls.builtins.formatting.stylua.with({ -- formatter for Lua code.
        -- INFO: Configure Stylua to format Lua code with two Space characters.
        extra_args = { "indent-type", "Spaces", "indent-width", "2" },
      }),
      null_ls.builtins.diagnostics.selene.with({ -- linter for Lua code.
        -- INFO: Load the "selene" linter only if its configuration file exists in the project directory.
        condition = function(utils)
          return utils.root_has_file({ "selene.toml", "vim.toml" })
        end,
      }),
      null_ls.builtins.diagnostics.eslint_d, -- A faster version of ESLint (linter for TS/JS code).
      null_ls.builtins.formatting.prettier.with({
        prefer_local = "node_modules/.bin",
      }),
      -- FIXME: "prettierd" doesn't follow the configurations setup in the ".prettierrc.json" file.
      -- null_ls.builtins.formatting.prettierd.with({
      --     -- INFO: Configure "prettierd" to add 2 spaces since it doesn't follow the ".prettierrc" configurations
      --     extra_args = { "tab-width", "2" },
      -- }), -- A faster version of Prettier (formatter for TS/JS code).
      null_ls.builtins.formatting.black, -- formatter for Python code.
      null_ls.builtins.diagnostics.mypy, -- static type checker for Python code.
      null_ls.builtins.diagnostics.pydocstyle, -- linter for checking standard practices in Python code.
      null_ls.builtins.formatting.isort, -- import sorter for Python code.
      null_ls.builtins.diagnostics.flake8, -- linter for ensuring uniform coding practices in Python code.
    },
  })
end

return M
