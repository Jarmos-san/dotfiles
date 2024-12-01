local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Snippet to create the script template
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

  -- Snippet for creating the style template
  snippet(
    { trig = "style", desc = "Create a style template block" },
    fmt(
      [[
  <style lang='scss' scoped>
  {1}
  </style>
  ]],
      { insert_node(1, "") }
    )
  ),
}
