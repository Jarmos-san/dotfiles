-- Module for configuring the Luasnip snippets engine

return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make jsregexp",
  opts = {
    region_check_events = "InsertEnter",
    delete_check_events = "InsertEnter",
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
  end,
}
