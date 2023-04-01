local null_ls = require("null-ls")

null_ls.setup({
  border = "rounded", -- Enable a nice-looking UI for the plugin's floating window
  on_attach = function(client, bufnr) -- Functionality for the LSP when it attaches to the buffer
    -- Check if the server supports LSP-based formatting
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("formatter_group", { clear = true }),
        buffer = bufnr,
        callback = function()
          -- Enable the builtin formatting capabilities of Neovim to use the plugin
          vim.lsp.buf.format({
            timeout_ms = 6000, -- Don't take longer than 6secs to format a buffer
            bufnr = bufnr,
            filter = function()
              -- Only use the plugin's capabilities to format the contents of the buffer
              return client.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.formatting.stylua.with({ -- Formatter for Lua files
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    -- INFO: This is probably broken on old OSes. See the following thread for guidance if a similar error was raised:
    -- https://askubuntu.com/questions/421642/libc-so-6-version-glibc-2-14-not-found
    null_ls.builtins.diagnostics.selene.with({
      -- Linter for Lua files
      condition = function(utils) -- Only enable the linter if its configuration files exists
        return utils.root_has_file({ "selene.toml", "vim.toml" })
      end,
    }),
    null_ls.builtins.formatting.shfmt, -- Formatter for Bash/Shell files
    null_ls.builtins.code_actions.shellcheck, -- Code Actions for Bash/Shell files
    null_ls.builtins.diagnostics.shellcheck, -- Formatter for Bash/Shell files
    null_ls.builtins.formatting.black.with({ -- Formatter for Python files
      prefer_local = ".venv/bin",
    }),
    -- Diagnostics for ESLint files
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        -- Load this tool only if its configuration file exists in the current working directory
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json" })
      end,
    }),
    null_ls.builtins.diagnostics.ruff.with({
      -- Super fast diagnostics tool for Python files
      extra_args = { "--fix" }, -- Automatically attempt to fix linting concerns using Ruff's rules
      prefer_local = ".venv/bin", -- Prefer using the virtual environment local binary for better project identification
    }),
    null_ls.builtins.diagnostics.mypy.with({ -- Static type check for Python files
      prefer_local = ".venv/bin", -- Use the project local binary instead of the system one
    }),
    null_ls.builtins.formatting.prettier.with({
      -- Formatter for web dev files
      prefer_local = "node_modules/.bin",
      extra_args = { "--prose-wrap", "always" },
    }),
    -- FIXME: Reports false-negatives when working with certain TOML files like "pyproject.toml"
    -- null_ls.builtins.formatting.taplo, -- Formatter for TOML files
    null_ls.builtins.diagnostics.vale.with({
      -- Diagnostics tool for spell checking
      condition = function(utils)
        -- Only enable the Vale diagnostic tool if the Vale config file exists in the project root directory
        return utils.root_has_file({ ".vale.ini" })
      end,
    }),
    null_ls.builtins.formatting.rustfmt, -- Formatter for Rust files
  },
})
