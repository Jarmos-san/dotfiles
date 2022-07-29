-- Custom configurations for the "null-ls" plugin which acts as a auxiliary plugin for the Neovim's LSP client.
return function(config)
  local null_ls = require("null-ls")

  config.sources = {
    -- INFO: Following entries are all formatters
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "column-width", "80" },
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort.with({
      extra_args = { "--multi-line", "3", "--profile", "black" },
    }),

    -- INFO: Following entries are all linters
    -- TODO: Fix the conflicting style issues with formatters
    -- null_ls.builtins.diagnostics.selene,
    -- INFO: Its probably best to use the OG ESLint instead of the daemon version which causes unneccessary issues.
    null_ls.builtins.diagnostics.eslint,
    -- INFO: The following two Python linters aren't necessary when Flake8 is used.
    -- null_ls.builtins.diagnostics.pylint,
    -- null_ls.builtins.diagnostics.pydocstyle,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.flake8,
  }

  -- set up null-ls's on_attach function
  config.on_attach = function(client)
    -- NOTE: You can remove this on attach function to disable format on save
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = function()
          vim.lsp.buf.formatting_sync(nil, 10000)
        end,
      })
    end
  end

  return config -- return final config table
end
