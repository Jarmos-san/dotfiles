-- Module for configuring and creating snippets using the LuaSnip snippet engine

local M = {}

M.config = function()
  local luasnip = require("luasnip")

  luasnip.setup({
    region_check_events = "InsertEnter",
    delete_check_events = "InsertEnter",
  })

  -- TODO: Configure the snippets somehow!
end

return M
