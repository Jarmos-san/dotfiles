-- Module for configuring the autocompletion plugin.
-- NOTE: The configuration for this plugin is a mess. The docs aren't good either & the source code design is bad.
-- So either copy + paste the configurations & pray things work or refer to the repository wiki for more information.

local M = {}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  -- FIXME: Not sure what it exactly does.
  -- require("cmp_luasnip_choice").setup({ auto_open = true })

  luasnip.setup({
    region_check_events = "InsertEnter",
    delete_check_events = "InsertEnter",
  })

  require("luasnip.loaders.from_vscode").lazy_load()

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_get_buf_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
    enabled = function()
      local context = require("cmp.config.context")

      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    -- view = {
    --   entries = { name = 'custom', selection_order = 'near_cursor' }
    -- }
    preselect = cmp.PreselectMode.Item,
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
      documentation = cmp.config.disable,
    },
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
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expand_or_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "luasnip_choice" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
    },
  })

  -- Disable certain capabilities when working on Markdown files.
  cmp.setup.filetype({ "markdown" }, { sources = { name = "buffer" } })
end

return M
