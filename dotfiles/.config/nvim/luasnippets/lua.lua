local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  snippet(
    { trig = "func", desc = "Create a Lua function" },
    fmt(
      [[
  local {1} = function({2})
    {3}
  end
  ]],
      {
        insert_node(1, "function_name"),
        insert_node(2, "args"),
        insert_node(3, ""),
      }
    )
  ),
}
