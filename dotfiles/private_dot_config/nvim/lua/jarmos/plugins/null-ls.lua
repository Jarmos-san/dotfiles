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
      -- FIXME: Figure a way out to load it conditionally only when working on TypeScript projects.
      -- INFO: LSP-based code actions for TypeScript files using "null-ls".
      -- require("typescript.extensions.null-ls.code-actions"),

      -- formatter for Lua code.
      null_ls.builtins.formatting.stylua.with({
        -- INFO: Configure Stylua to format Lua code with two Space characters.
        extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      }),

      -- linter for Lua code.
      null_ls.builtins.diagnostics.selene.with({
        -- INFO: Load the "selene" linter only if its configuration file exists in the project directory.
        condition = function(utils)
          return utils.root_has_file({ "selene.toml", "vim.toml" })
        end,
      }),

      -- A faster version of ESLint (linter for TS/JS code).
      null_ls.builtins.diagnostics.eslint_d,

      -- Prettier formatter for frontend projects.
      null_ls.builtins.formatting.prettierd.with({
        prefer_local = "node_modules/.bin",
        condition = function(utils)
          -- INFO: Only load the "prettier" source if the following files exists in the project root.
          return utils.root_has_file({
            "package.json",
            ".prettierrc",
            ".prettierrc.json",
            "prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            "prettier.config.js",
            "prettier.config.cjs",
            ".prettierrc.toml",
          })
        end,
      }),

      -- Formatter for Python code.
      null_ls.builtins.formatting.black.with({
        prefer_local = ".venv/bin",
      }),

      -- Static type checker for Python code.
      null_ls.builtins.diagnostics.mypy.with({
        prefer_local = ".venv/bin",
        condition = function(utils)
          -- INFO: Only load "mypy" when a "pyproject.toml" file exists in the root directory.
          return utils.root_has_file({
            "pyproject.toml",
          })
        end,
      }),

      -- Linter for Python docstrings.
      null_ls.builtins.diagnostics.pydocstyle.with({
        prefer_local = ".venv/bin",
        condition = function(utils)
          -- INFO: Only load "pydocstyle" when a "pyproject.toml" file exists in the root directory.
          return utils.root_has_file({
            "pyproject.toml",
          })
        end,
      }),

      -- Formatter for sorting Python import statements.
      null_ls.builtins.formatting.isort.with({
        prefer_local = ".venv/bin",
      }),

      -- Linter for general Pyhon code.
      null_ls.builtins.diagnostics.flake8.with({
        prefer_local = ".venv/bin",
        condition = function(utils)
          -- INFO: Only load "flake8" when a ".flake8" file exists in the root directory.
          return utils.root_has_file({
            ".flake8",
          })
        end,
      }),

      -- Formmatter for Rust code.
      null_ls.builtins.formatting.rustfmt,

      -- Diagnostics for prose (like Markdown & other text files).
      null_ls.builtins.diagnostics.vale.with({
        condition = function(utils)
          return utils.root_has_file({
            ".vale.ini",
          })
        end,
      }),

      -- Linter for Python projects.
      null_ls.builtins.diagnostics.ruff,
    },
  })
end

return M
