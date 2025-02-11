-- Module for configuring the completion capabilities of Neovim

return {
  "saghen/blink.cmp",
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
    keymap = {
      preset = "enter",
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
          winblend = 0,
        },
      },
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          auto_insert = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
        },
      },
      ghost_text = {
        enabled = true,
      },
      menu = {
        border = "rounded",
        winblend = 0,
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label" },
            { "source_name" },
          },
        },
      },
    },
  },
  dependencies = "L3MON4D3/LuaSnip",
}
