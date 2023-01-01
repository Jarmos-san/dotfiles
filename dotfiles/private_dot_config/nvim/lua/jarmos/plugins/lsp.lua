--[[
Module for configuring the builti-in LSP client.
--]]

local M = {}

function M.setup_lsp()
  -- Necessary for Neovim to show the diagnostic hover window as quick as possible.
  vim.o.updatetime = 250

  -- Utlity function to make assigning diagnostic symbols more easily.
  local sign = function(severity, icon)
    local highlight = "Diagnostics" .. severity

    vim.fn.sign_define("DiagnosticsSign" .. severity, { text = icon, texthl = highlight, numhl = highlight })
  end

  sign("Error", "")
  sign("Warn", "")
  sign("Info", "")
  sign("Hint", "")

  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
  })

  local on_attach = function(_, bufnr)
    local map = vim.keymap
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map.set("n", "gD", vim.lsp.buf.declaration, opts)
    map.set("n", "gd", vim.lsp.buf.definition, opts)
    map.set("n", "K", vim.lsp.buf.hover, opts)
    map.set("n", "gi", vim.lsp.buf.implementation, opts)
    map.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    map.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    map.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders))
    end, opts)
    map.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    map.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map.set("n", "gr", vim.lsp.buf.references, opts)

    -- Configurations for showing diagnostics in a hover window instead. See the documentations at:
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local hover_window_configs = {
          focusable = true,
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

  local lspconfig = require("lspconfig")
  -- Separate Lua plugin necessary for proper TypeScript LSP support. For more information on this plugin, refer to:
  -- https://github.com/jose-elias-alvarez/typescript.nvim
  local typescript_lspconfig = require("typescript")

  lspconfig.cssls.setup({
    capabilities = capabilities,
  })

  -- Initialisation for the Bash LSP server.
  lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Initialisation for the Docker LSP server.
  lspconfig.dockerls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Initialisation for the JSON LSP server.
  lspconfig.jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Initialisation for the Python LSP server.
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Initialisation for the YAML LSP server.
  lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-action.json"] = ".github/workflows/*",
        },
      },
    },
  })

  -- Initialisation for the Lua LSP server.
  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Set the correction version of the embedded Lua environment.
          version = "LuaJIT",
        },
        diagnostics = {
          -- configure the LSP server to understand the "vim" namespace.
          globals = { "vim" },
        },
        workspace = {
          -- configure the LSP server to understand where to look for Neovim runtime files.
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          -- Disable telemetry for privacy concerns.
          enable = false,
        },
      },
    },
  })

  typescript_lspconfig.setup({
    server = {
      on_attach = on_attach,
    },
  })
end

function M.setup_completions()
  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local luasnip = require("luasnip")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local lspkind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  cmp.setup({
    -- Customise the appearance of the completion menu.
    view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    },
    -- INFO: Disable the autocompletion popup menu when typing comments.
    enabled = function()
      local context = require("cmp.config.context")
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    -- INFO: Make the completion menu more informative & good-looking.
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          nvim_lua = "[Neovim]",
        })[entry.source.name]
        return vim_item
      end,
    },
    -- INFO: Enable snippet support within the automcompletion popup menu.
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    -- INFO: Enable a nice looking border around the completion menu to make it look nicer.
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    -- INFO: Enable some keybindings to be invoked when automcompletion is required.
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
    -- INFO: Sources required by the "nvim-cmp" plugin to provide core autocompletion features.
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lsp_signature_help" },
      { name = "path" },
    }),
  })

  -- Disable certain completion capabilities when working on Markdown files.
  cmp.setup.filetype({ "markdown" }, { sources = { name = "buffer" } })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
