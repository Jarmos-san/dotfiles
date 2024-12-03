local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Define the snippet for Python function definitions
  snippet(
    { trig = "def", desc = "Create a Python function definition" },
    fmt( -- The format of the snippet
      [[
      def {1}({2}: {3}) -> {4}:
          """{5}.

          Args:
            {2}: {6}.

          Returns:
            {4}: {7}

          Raises:
            {8}
          """
          {9}
      ]],
      { -- The node of the snippet to replace content with
        insert_node(1, "function_name"),
        insert_node(2, "arg"),
        insert_node(3, "ArgumentType"),
        insert_node(4, "ReturnType"),
        insert_node(5, "Describe the function briefly."),
        insert_node(6, "Explain the argument briefly."),
        insert_node(7, "Explain the return type briefly."),
        insert_node(8, "Exception"),
        insert_node(9, ""),
      },
      {
        repeat_duplicates = true, -- Ensure duplicates content are copied as-is
      }
    )
  ),

  -- Define the snippet for Python classes
  snippet(
    { trig = "class", desc = "Create a Python class implementation" },
    fmt(
      [[
        class {1}({2}):
            """{3}"""

            {4}
        ]],
      {
        insert_node(1, "ClassName"),
        insert_node(2, "ParentClassName"),
        insert_node(3, "Briefly describe the class and its characteristics."),
        insert_node(4, ""),
      }
    )
  ),

  -- Snippet for the "if __name__ == '__main__:' logic"
  snippet(
    { trig = "__main__", desc = "Create logic to invoke the Python script with apt shebang" },
    fmt(
      [[
  if __name__ == '__main__':
      main()
  ]],
      {}
    )
  ),

  -- Snippet for the "__repr__" function
  snippet(
    { trig = "__repr__", desc = "Implement a class's __repr__ method" },
    fmt(
      [[
  def __repr__(self) -> str:
      """{1}"""
      return f"{{{2}}}"
  ]],
      {
        insert_node(1, "Return a string representation of the class instance for debugging."),
        insert_node(2, ""),
      }
    )
  ),

  -- Snippet for if-else statements
  snippet(
    { trig = "if-else", desc = 'Create an "if-else" logic block' },
    fmt(
      [[
  if {1}:
      {2}
  else:
      {3}
  ]],
      {
        insert_node(1, ""),
        insert_node(2, ""),
        insert_node(3, ""),
      }
    )
  ),

  -- Snippets for match-case statements
  snippet(
    { trig = "match", desc = "Create a match statement" },
    fmt(
      [[
  match {1}:
      case {2}:
          {3}
      case _:
          {4}
  ]],
      {
        insert_node(1, ""),
        insert_node(2, ""),
        insert_node(3, ""),
        insert_node(4, ""),
      }
    )
  ),

  -- Snippets for creating Pyright directives
  snippet(
    { trig = "pyright", desc = "Create a Pyright directive" },
    fmt(
      [[
      # pyright: ignore[{1}]
  ]],
      { insert_node(1, "directive") }
    )
  ),

  -- Snippets for creating "noqa" directives (possibly used by tools like Ruff)
  snippet(
    { trig = "noqa", desc = "Create a directive for tools like Ruff" },
    fmt(
      [[
    # noqa: {1}
  ]],
      { insert_node(1, "directive") }
    )
  ),

  -- Snippet to generate a testcase function
  snippet(
    { trig = "testfunc", desc = "Create a testcase function" },
    fmt(
      [[
  def test_{1}() -> None:
      """{2}"""
      {3}
      assert False
  ]],
      { insert_node(1, ""), insert_node(2, "A brief test case function description."), insert_node(3, "") }
    )
  ),

  -- Snippet to generate a testcase class
  snippet(
    { trig = "testclass", desc = "Create a test class" },
    fmt(
      [[
  class Test{1}():
      """{2}"""

      def {3}(self) -> {4}:
          """{5}"""
          return {4}

      def test_{6}(self) -> None:
          """{7}"""
          {8}
          assert False
  ]],
      {
        insert_node(1, ""),
        insert_node(2, "Describe the test class"),
        insert_node(3, "fixture"),
        insert_node(4, "ReturnType"),
        insert_node(5, "Describe the fixture"),
        insert_node(6, ""),
        insert_node(7, "Describe the test function"),
        insert_node(8, ""),
      }
    )
  ),
}
