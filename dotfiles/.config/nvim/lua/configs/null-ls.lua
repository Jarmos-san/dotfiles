-- Module for configuring the "null-ls" plugin

local M = {}

M.config = function()
  local null_ls = require("null-ls")

  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local code_actions = null_ls.builtins.code_actions

  -- Utility wrapper to make configuring the native vim.lsp.buf.format() function easier to use
  local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
      async = false,
    })
  end

  -- Callback function to invoke after the Null-Ls is up & running
  local on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Check if the LSP supports formatting capabilities
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end

  local sources = {
    formatting.stylua.with({ -- Formatter for Lua files
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    -- INFO: This is probably broken on old OSes. See the following thread for guidance if a similar error was raised:
    -- https://askubuntu.com/questions/421642/libc-so-6-version-glibc-2-14-not-found
    diagnostics.selene.with({ -- Linter for Lua files
      condition = function(utils) -- Only enable the linter if its configuration files exists
        return utils.root_has_file({ "selene.toml", "vim.toml" })
      end,
    }),
    formatting.shfmt.with({ -- Formatter for Bash/Shell files
      -- INFO: Configure "shfmt" to adhere to Google style guide.
      -- See the examples as shared in the official repository below:
      -- https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd#examples
      extra_args = { "-i", "2", "-ci", "-bn" },
    }),
    code_actions.shellcheck, -- Code Actions for Bash/Shell files
    diagnostics.shellcheck, -- Diagnostics for Bash/Shell files
    formatting.black.with({ -- Formatter for Python files
      prefer_local = ".venv/bin",
    }),
    diagnostics.eslint_d.with({ -- Diagnostics for ESLint files
      condition = function(utils)
        -- Load this tool only if its configuration file exists in the current working directory
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json" })
      end,
    }),
    diagnostics.ruff.with({ -- Super fast diagnostics tool for Python files
      prefer_local = ".venv/bin", -- Prefer using the virtual environment local binary for better project identification
    }),
    formatting.ruff.with({ -- Super fast formatting tool for Python files
      prefer_local = ".venv/bin", -- Prefer using the virtual environment local binary for better project identification
    }),
    formatting.prettier.with({ -- Formatter for web dev files
      prefer_local = "node_modules/.bin",
      extra_args = { "--prose-wrap", "always" },
    }),
    -- FIXME: Reports false-negatives when working with certain TOML files like "pyproject.toml"
    -- formatting.taplo, -- Formatter for TOML files
    diagnostics.vale.with({ -- Diagnostics tool for spell checking
      condition = function(utils)
        -- Only enable the Vale diagnostic tool if the Vale config file exists in the project root directory
        return utils.root_has_file({ ".vale.ini" })
      end,
    }),
    formatting.rustfmt, -- Formatter for Rust files
  }

  -- Initialise the plugin with the aforementioned configurations
  null_ls.setup({ border = "rounded", on_attach = on_attach, sources = sources })
end

return M
