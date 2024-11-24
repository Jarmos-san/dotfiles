local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Snippet for defining a function
  snippet(
    { trig = "func", desc = "Create a function definition" },
    fmt(
      [[
  func {1}({2} {3}) ({4}) {{
      return {5}
  }}
  ]],
      {
        insert_node(1, "FunctionName"),
        insert_node(2, "Argument"),
        insert_node(3, "ArgumentType"),
        insert_node(4, "ReturnType"),
        insert_node(5, ""),
      }
    )
  ),

  -- Snippet to create a Go struct
  snippet(
    { trig = "struct", desc = "Create a Go struct" },
    fmt(
      [[
  type {1} struct {{
      {2}
  }}
  ]],
      { insert_node(1, "StructName"), insert_node(2, "") }
    )
  ),

  -- Snippet to create struct method
  snippet(
    { trig = "method", desc = "Create a struct method" },
    fmt(
      [[
  func ({1}) {2}({3}) {4} {{
      return {5}
  }}
  ]],
      {
        insert_node(1, "Struct"),
        insert_node(2, "Method"),
        insert_node(3, "Args"),
        insert_node(4, "ReturnType"),
        insert_node(5, ""),
      }
    )
  ),

  -- Snippet to create an interface
  snippet(
    { trig = "interface", desc = "Create an interface" },
    fmt(
      [[
  type {1} interface {{
      {2}({3} {4}) {5}
  }}
  ]],
      {
        insert_node(1, "InterfaceName"),
        insert_node(2, "MethodName"),
        insert_node(3, "Argument"),
        insert_node(4, "ArgumentType"),
        insert_node(5, "ReturnType"),
      }
    )
  ),

  -- Snippet for error handling
  snippet(
    { trig = "err", desc = "Create an error handling block" },
    fmt(
      [[
  if err != nil {{
      return {1}
  }}
  ]],
      { insert_node(1, "err") }
    )
  ),

  -- Snippet for a basic for-loop
  snippet(
    { trig = "for", desc = "Create a basic for-loop snippet" },
    fmt(
      [[
  for {1} {{
      {2}
  }}
  ]],
      { insert_node(1, "i := 0; i < n; i++"), insert_node(2, "Statement") }
    )
  ),

  -- Snippet to generate a testcase function
  snippet(
    { trig = "test", desc = "Create a snippet to generate a test function" },
    fmt(
      [[
  func Test{1}(t *testing.T) {{
      {2}
  }}
  ]],
      {
        insert_node(1, "Name"),
        insert_node(2, ""),
      }
    )
  ),

  -- Snippet to create a map
  snippet(
    { trig = "map", desc = "Create a map object" },
    fmt(
      [[
  map[{1}]{2} {{
      {3}
  }}
  ]],
      { insert_node(1, "KeyType"), insert_node(2, "ValueType"), insert_node(3, "") }
    )
  ),

  -- Snippet to create a channel
  snippet(
    { trig = "chan", desc = "Create a snippet for channels" },
    fmt(
      [[
  make(chan {1})
  ]],
      insert_node(1, "Type")
    )
  ),

  -- Snippet for generating function documentations
  snippet(
    { trig = "fndoc", desc = "Create a snippet for function documentations" },
    fmt(
      [[
  /**
   * {1} - {2}
   *
   * Parameters:
   * {3}
   *
   * Returns:
   * {4}
   */
  ]],
      {
        insert_node(1, "FunctionName"),
        insert_node(2, "Description"),
        insert_node(3, "param1 Type, param2 Type"),
        insert_node(4, "Return description"),
      }
    )
  ),

  -- Snippet for creating documentations for structs
  snippet(
    { trig = "structdoc", desc = "Create a snippet for generating struct documentations" },
    fmt(
      [[
  /**
   * {1} - {2}
   *
   * Fields:
   * {3}
   */
  ]],
      {
        insert_node(1, "StructName"),
        insert_node(2, "Description"),
        insert_node(3, "Field1: Type // Field description"),
      }
    )
  ),

  -- Snippet for creating documentation for packages
  snippet(
    { trig = "pkgdoc", desc = "Create a snippet for generating package documentations" },
    fmt(
      [[
  /**
   * Package {1} - {2}
   */
  ]],
      { insert_node(1, "packageName"), insert_node(2, "Description of th package") }
    )
  ),

  -- Snippet for creating documentation for methods
  snippet(
    { trig = "methoddoc", desc = "Create a snippet for generating documentations for struct methods" },
    fmt(
      [[
  /**
   * {1} - {2} method of {3}
   *
   * Parameters:
   * {4}
   *
   * Returns:
   * {5}
   */
  ]],
      {
        insert_node(1, "MethodName"),
        insert_node(2, "Description"),
        insert_node(3, "StructName"),
        insert_node(4, "arg Type // Description"),
        insert_node(5, "ReturnType // Description"),
      }
    )
  ),

  -- Snippet for creating documentations for struct fields
  snippet(
    { trig = "fields", desc = "Create a snippet for generating documentations for struct fields" },
    fmt(
      [[
  // {1}: {2} - {3}
  ]],
      { insert_node(1, "FieldName"), insert_node(2, "Type"), insert_node(3, "Field Description") }
    )
  ),

  -- Snippet for generating the documentations for errors
  snippet(
    { trig = "errdoc", desc = "Creating a snippet for generating documentations for errors" },
    fmt([[ // {1}: {2} - {3}]], { insert_node(1, "ErrorName"), insert_node(2, "Type"), insert_node(3, "Description") })
  ),
}
