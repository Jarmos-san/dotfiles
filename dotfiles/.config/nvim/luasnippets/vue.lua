local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  snippet(
    { trig = "script", desc = "Create a script block" },
    fmt(
      [[
  <script lang='ts' setup>
    {1}
  </script>
  ]],
      { insert_node(1, "") }
    )
  ),
}
