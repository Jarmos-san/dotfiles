-- Module for configuring the "nvim-lspconfig" plugin

local M = {}

M.init = function()
  vim.opt.updatetime = 250 -- Make Neovim to display the diagnostic hover window as fast as possible.
  -- Setup the LSP plugin to log only error messages else the log file grows too large eventually!
  vim.lsp.set_log_level("error")
  vim.diagnostic.config({
    underline = true, -- Show diagnostic errors with a squigly underline
    update_in_insert = true, -- Update the diagnostic message even when in Insert mode
    severity_sort = true, -- Configure Neovim to sort the error messages according to the severity.
  })
end

M.config = function()
  local lspconfig = require("lspconfig")
  local typescript_ls = require("typescript-tools")
  local rust_ls = require("rust-tools")

  -- Add rounded borders to the LSP flaoting windows
  require("lspconfig.ui.windows").default_options.border = "rounded"

  local on_attach = function(_, bufnr)
    local wk = require("which-key")

    -- INFO: Configure the "which-key" plugin to keep a track of the LSP keybindings
    wk.register({
      ["<leader>l"] = {
        name = "+LSP",
        D = { vim.lsp.buf.declaration, "Jump to the object declaration" },
        K = { vim.lsp.buf.hover, "Open the documentations of the object" },
        i = { vim.lsp.buf.implementation, "Jump to the implementation" },
        k = { vim.lsp.buf.signature_help, "Get the help documentations" },
        T = { vim.lsp.buf.type_definition, "Get the type definition" },
        r = { vim.lsp.buf.rename, "Rename the object under the cursor" },
        R = { vim.lsp.buf.references, "Jump to the reference of the object" },
        c = { vim.lsp.buf.code_action, "Open available code actions" },
        d = { vim.lsp.buf.definition, "Jump to object definition" },
      },
      ["<leader>w"] = {
        name = "+Workspace",
        a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
        l = { vim.inspect(vim.lsp.buf.list_workspace_folders), "List workspace folder" },
      },
    })

    -- Configurations for showing diagnostics in a hover window instead. See the documentations at:
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local hover_window_configs = {
          -- This needs to be false else the cursor swtiches to the diagnostic window.
          -- See this discussion thread for more information on this concern:
          -- https://neovim.discourse.group/t/cursor-switching-floating-window-diagnostic-on-movement/1471/2?u=jarmos-san
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "cursor",
        }

        vim.diagnostic.open_float(nil, hover_window_configs)
      end,
    })
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- INFO: Necessary configuration for the JSON LSP server. See the following URL for more information:
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- INFO: The official recommended configurations will throw a lot of errors and is generally very buggy!
  -- LSP configurations for Lua files
  lspconfig["lua_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        format = { enable = false }, -- Disable the LSP-based formatting
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" },
          enable = false, -- Disable Lua diagnostics since it interferes with Selene
        },
        workspace = {
          -- Load the Neovim runtime files for usage during Neovim configuration
          library = vim.api.nvim_get_runtime_file("", true),
          -- Disable checking for 3rd-party libraries
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })

  -- LSP configurations for JSON files
  lspconfig["jsonls"].setup({
    on_attach = on_attach,
    capabilties = capabilities,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  -- LSP configurations for YAML files
  lspconfig["yamlls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://taskfile.dev/schema.json"] = "Taskfile.yml",
        },
      },
    },
  })

  -- LSP configurations for TypeScript projects
  typescript_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      tsserver_file_preferences = {
        disableSuggestions = true,
      },
    },
  })

  -- LSP configurations for Rust projects
  rust_ls.setup({
    server = { on_attach = on_attach },
  })

  -- LSP configurations for Bash
  lspconfig["bashls"].setup({ on_attach = on_attach, capabilities = capabilities })

  -- LSP configurations for Dockerfile
  lspconfig["dockerls"].setup({ on_attach = on_attach, capabilities = capabilities })

  -- LSP configurations for Python files
  -- INFO: Experimenting with an alternative Python LSP
  -- lspconfig["pyright"].setup({ on_attach = on_attach, capabilities = capabilities })
  lspconfig["jedi_language_server"].setup({ on_attach = on_attach, capabilities = capabilities })

  -- LSP configurations for TailwindCSS classes
  lspconfig["tailwindcss"].setup({ on_attach = on_attach, capabilities = capabilities })

  -- LSP configurations for TOML files
  -- lspconfig["taplo"].setup({ on_attach = on_attach, capabilities = capabilities })

  lspconfig["gopls"].setup({ on_attach = on_attach, capabilities = capabilities })
end

return M
