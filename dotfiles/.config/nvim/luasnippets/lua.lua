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

  snippet(
    { trig = "req", desc = "Create a require statement" },
    fmt(
      [[
  local {1} = require('{2}')
  ]],
      { insert_node(1, ""), insert_node(2, "module_name") }
    )
  ),

  snippet(
    { trig = "if", desc = "Create an if statement" },
    fmt(
      [[
  if {1} then
    {2}
  end
  ]],
      { insert_node(1, "condition"), insert_node(2, "body") }
    )
  ),
}
