-- Module for configuring the completion capabilities of Neovim

return {
  -- Better autocompletion support for Neovim.
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- FIXME: Not sure what it exactly does.
    -- require("cmp_luasnip_choice").setup({ auto_open = true })

    -- Check if there any preceeding words to either autocomplete or place Tab characters
    local has_words_before = function()
      local _, col = unpack(vim.api.nvim_win_get_cursor(0))

      -- Return false if the cursor is at the start of the line without any preceeding characters
      if col == 0 then
        return false
      end

      local line_content = vim.api.nvim_get_current_line()
      local char_before_cursor = line_content:sub(col, col)

      return char_before_cursor:match("%s") == nil
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
      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
        },
      },
      enabled = function()
        local context = require("cmp.config.context")

        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
      end,
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
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.expand_or_jumpable(-1) then
            luasnip.jump(-1)
          else
            vim.fn.feedkeys("\t", "n")
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
        {
          name = "buffer",
          option = {
            keyword_length = 6,
          },
        },
      },
    })

    -- Disable certain capabilities when working on Markdown files.
    cmp.setup.filetype({ "markdown" }, { sources = { name = "buffer" } })
  end,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "saadparwaiz1/cmp_luasnip",
  },
}
