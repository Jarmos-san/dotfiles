-- Module for configuring the Luasnip snippets engine

return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make install_jsregexp",
  opts = {
    region_check_events = "InsertEnter",
    delete_check_events = "InsertEnter",
  },
  config = function(_, opts)
    local luasnip = require("luasnip")
    local snippet = luasnip.snippet
    local insert_node = luasnip.insert_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Configure LuaSnip according to the options set in the "opts" table
    luasnip.setup(opts)

    -- Create snippets for Python files
    luasnip.add_snippets("python", {
      -- Define the snippet for Python function definitions
      snippet(
        "def", -- The keyword to trigger the snippet
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
        "class", -- The keyword to trigger the snippet
        fmt(
          [[
        class {1}():
            """Insert docstring."""

            {2}
        ]],
          {
            insert_node(1, "ClassName"),
            insert_node(2, ""),
          }
        )
      ),
    })
  end,
}
