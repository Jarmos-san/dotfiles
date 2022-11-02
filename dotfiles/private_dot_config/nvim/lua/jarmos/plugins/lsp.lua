--[[
Module for configuring the builti-in LSP client.
--]]

local M = {}

function M.setup_lsp()
  local sign = function(severity, icon)
    local highlight = "Diagnostics" .. severity

    vim.fn.sign_define("DiagnosticsSign" .. severity, { text = icon, texthl = highlight, numhl = highlight })
  end

  sign("Error", "")
  sign("Warn", "")
  sign("Info", "")
  sign("Hint", "")

  vim.diagnostic.config({
    underline = true,
    signs = true,
    float = { header = false, source = "always" },
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
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- INFO: Necessary configuration for the JSON LSP server. See the following URL for more information:
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local lspconfig = require("lspconfig")

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
          ["https://json.schemastore.org/github-action,json"] = ".github/workflows/*",
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
end

-- Special initialisation for the TypeScript LSP server. See the following repository for more information:
-- https://github.com/jose-elias-alvarez/typescript.nvim
function M.setup_typescript_lsp()
  local on_attach = function()
    -- TODO: Add some keymaps & other LSP-based logic over here.
  end

  require("typescript").setup({
    server = {
      on_attach = on_attach,
    },
  })
end

function M.setup_completions()
  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

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
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- INFO: Enable a nice looking border around the completion menu to make it look nicer.
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    -- INFO: Enable some keybindings to be invoked when automcompletion is required.
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
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

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
