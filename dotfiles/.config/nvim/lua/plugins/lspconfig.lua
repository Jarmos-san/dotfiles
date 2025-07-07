-- Module for configuring the plugin responsible for handling LSP configurations

return {
  -- Official plugin for more ease in configuring the in-built LSP client.
  "neovim/nvim-lspconfig",
  event = "LspAttach",
  init = function()
    vim.opt.updatetime = 250 -- Make Neovim to display the diagnostic hover window as fast as possible.
    -- Setup the LSP plugin to log only error messages else the log file grows too large eventually!
    vim.lsp.set_log_level(vim.log.levels.ERROR)
    vim.diagnostic.config({
      underline = true, -- Show diagnostic errors with a squigly underline
      update_in_insert = true, -- Update the diagnostic message even when in Insert mode
      severity_sort = true, -- Configure Neovim to sort the error messages according to the severity.
      virtual_lines = true, -- Display prettier diagnostics on the buffer
    })
    -- Configure the floating window containing information about the object under the cursor
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "double", -- Enable a distinguishable border for the window
      max_width = math.floor(vim.o.columns * 0.5), -- Cap the width of window at 50% of the terminal size
    })
  end,
  config = function()
    local lspconfig = require("lspconfig")
    local map = require("utils").map
    local telescope = require("telescope.builtin")

    -- Add rounded borders to the LSP flaoting windows
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local on_attach = function(_, bufnr)
      map("n", "gd", telescope.lsp_definitions, { desc = "Jump to the object definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to the object declaration" })
      map("n", "gT", telescope.lsp_type_definitions, { desc = "Get the type documentations" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Jump to the implementation" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Open the documentations of the object" })
      map("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "Get the help documentations" })
      map("n", "gr", vim.lsp.buf.rename, { desc = "Rename the object under the cursor" })
      map("n", "gR", telescope.lsp_references, { desc = "Jump to the reference of the object" })
      map("n", "gra", vim.lsp.buf.code_action, { desc = "Open available code actions" })
      map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
      map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
      map("n", "<leader>wl", vim.lsp.buf.list_workspace_folders, { desc = "List workspace folders" })

      -- Configurations for showing diagnostics in a hover window instead. See the documentations at:
      -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local hover_window_configs = {
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

    local capabilities = require("blink.cmp").get_lsp_capabilities()

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
            enable = true, -- Disable Lua diagnostics since it interferes with Selene
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
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
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

    --[[
    -- Configurations required for the Vue LSP server to work as expected
    --]]
    -- Path to the LSP server executable
    local vue_language_server_path = vim.fn.stdpath("data")
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

    -- Configuration to initialise the 'vtsls' LSP server with
    -- NOTE: The VUe LSP server does not work as expected with the official `tsserver`
    local vtsls_config = {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
              },
            },
          },
        },
      },
    }

    -- Configurations the Vue LSP is supposed to be initialised with
    local vue_ls_config = {
      on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
          local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
          if #clients == 0 then
            vim.notify("Could not find `vtsls` LSP client, `vue_ls` would not work without it.", vim.log.levels.ERROR)
            return
          end

          local ts_client = clients[1]

          local param = unpack(result)
          local id, command, payload = unpack(param)
          ts_client:exec_cmd({
            title = "vue_request_forward",
            command = "typescript.tsserverRequest",
            arguments = {
              command,
              payload,
            },
          }, {
            bufnr = context.bufnr,
          }, function(_, r)
            local response_data = { {
              id,
              r.body,
            } }
            client:notify("tsserver/response", response_data)
          end)
        end
      end,
    }

    vim.lsp.config("vtsls", vtsls_config)
    vim.lsp.config("vue_ls", vue_ls_config)
    vim.lsp.enable({ "vtsls", "vue_ls" })

    -- Enable the LSP for Ansible work
    lspconfig["ansiblels"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Enable the LSP for Typst files
    lspconfig["tinymist"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        formatterMode = "typstyle",
      },
    })
  end,
  dependencies = {
    -- This plugin needs to be loaded as well otherwise Neovim can't find the LSP binary on $PATH.
    "williamboman/mason.nvim",
  },
}
