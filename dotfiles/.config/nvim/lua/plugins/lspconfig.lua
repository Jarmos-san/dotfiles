-- Module for configuring the plugin responsible for handling LSP configurations

return {
  -- Official plugin for more ease in configuring the in-built LSP client.
  "neovim/nvim-lspconfig",
  event = "LspAttach",
  init = function()
    vim.opt.updatetime = 250 -- Make Neovim to display the diagnostic hover window as fast as possible.
    -- Setup the LSP plugin to log only error messages else the log file grows too large eventually!
    vim.lsp.set_log_level("error")
    vim.diagnostic.config({
      underline = true, -- Show diagnostic errors with a squigly underline
      update_in_insert = true, -- Update the diagnostic message even when in Insert mode
      severity_sort = true, -- Configure Neovim to sort the error messages according to the severity.
    })
  end,
  config = function()
    local lspconfig = require("lspconfig")

    -- Add rounded borders to the LSP flaoting windows
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local on_attach = function(_, bufnr)
      local wk = require("which-key")

      wk.add({
        { "<leader>l", group = "LSP", icon = "󱥊" },
        { "<leader>lD", vim.lsp.buf.declaration, desc = "Jump to the object declaration", icon = "󱥊" },
        { "<leader>lK", vim.lsp.buf.hover, desc = "Open the documentations of the object", icon = "󱥊" },
        { "<leader>li", vim.lsp.buf.implementation, desc = "Jump to the implementation", icon = "󱥊" },
        { "<leader>lk", vim.lsp.buf.signature_help, desc = "Get the help documentations", icon = "󱥊" },
        { "<leader>lT", vim.lsp.buf.type_definition, desc = "Get the type documentations", icon = "󱥊" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename the object under the cursor", icon = "󱥊" },
        { "<leader>lR", vim.lsp.buf.references, desc = "Jump to the reference of the object", icon = "󱥊" },
        { "<leader>lc", vim.lsp.buf.code_action, desc = "Open available code actions", icon = "󱥊" },
        { "<leader>ld", vim.lsp.buf.definition, desc = "Jump to the object definition", icon = "󱥊" },

        { "<leader>w", group = "Workspace", icon = "󱥊" },
        { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder", icon = "󱥊" },
        { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder", icon = "󱥊" },
        { "<leader>wl", vim.lsp.buf.list_workspace_folders, desc = "List workspace folders", icon = "󱥊" },
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

    -- LSP configurations for Bash
    lspconfig["bashls"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- LSP configurations for Dockerfile
    lspconfig["dockerls"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- LSP configurations for Python files
    lspconfig["pyright"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- LSP configurations for TailwindCSS classes
    lspconfig["tailwindcss"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- LSP configurations for TOML files
    -- lspconfig["taplo"].setup({ on_attach = on_attach, capabilities = capabilities })

    lspconfig["gopls"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- LSP configurations for working with Astro files
    lspconfig["astro"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- CSS, SCSS and LESS LSP server configs
    lspconfig["cssls"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- Terraform and HCL related LSP configurations
    lspconfig["terraformls"].setup({
      filetypes = { "terraform", "hcl", "tf" },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- INFO: The TyepScript LSP is disable temporarily until I can figure out its usefulness
    -- Also, check out the issues with Volar (the LSP server for Vue.js) which might interfere
    -- with TypeScript projects.
    -- TypeScript and other related LSP configurations
    -- lspconfig["tsserver"].setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: See the following resources to learn more about configuring the LSP to work with
    -- Vue 3 projects (and its embedded language environments):
    -- https://github.com/vuejs/language-tools/issues/3925
    -- https://github.com/vuejs/language-tools?tab=readme-ov-file#none-hybrid-modesimilar-to-takeover-mode-configuration-requires-vuelanguage-server-version-207
    -- Vue 3 related LSP configurations
    lspconfig["volar"].setup({
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  dependencies = {
    -- This plugin needs to be loaded as well otherwise Neovim can't find the LSP binary on $PATH.
    "williamboman/mason.nvim",
  },
}
