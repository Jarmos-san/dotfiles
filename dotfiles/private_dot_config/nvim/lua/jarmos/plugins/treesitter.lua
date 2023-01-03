--[[
Module for configuring the Treesitter plugin in Neovim.
--]]

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "gitattributes",
      "gitignore",
      "help",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    highlight = { enable = true },
    incremental_selection = { enable = false },
    indent = { enable = false },
    folding = { enable = false },
    -- INFO: Configurations for "bracket coloriser" plugin
    -- https://github.com/p00f/nvim-ts-rainbow
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
    -- INFO: Configurations for the autotag plugin
    -- https://github.com/windwp/nvim-ts-autotag
    autotag = {
      enable = true,
    },
    -- INFO: Treesitter-based refactoring capabilities
    -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
    refactor = {
      highlight_definitions = { enable = true },
      -- INFO: I don't like the behaviour.
      -- highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    -- INFO: Treesitter-based plugin for textobject manipulation.
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- TODO: Add some more textobject manipulation keymappings after referring to the docs here:
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select a function block" },
          ["if"] = { query = "@function.inner", desc = "Select the contents of a function block" },
          ["ac"] = { query = "@class.outer", desc = "Select a class block" },
          ["ic"] = { query = "@class.outer", desc = "Select the contents of a class" },
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<leader>a"] = "@parameter.inner" },
        swap_previous = { ["<leader>A"] = "@parameter.inner" },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = { query = "@function.outer", desc = "Move to the start of the next function" },
          ["]]"] = { query = "@class.outer", desc = "Move to the start of the next class" },
        },
        goto_next_end = {
          ["]M"] = { query = "@function.outer", desc = "Move to the end of the next function" },
          ["]["] = { query = "@class.outer", desc = "Move to the end of the next class" },
        },
        goto_previous_start = {
          ["[m"] = { query = "@function.outer", desc = "Move to the start of the previous function" },
          ["[["] = { query = "@class.outer", desc = "Move to the end of the previous class" },
        },
        goto_previous_end = {
          ["[M"] = { query = "@function.outer", desc = "Move to the end of the previous function" },
          ["[]"] = { query = "@class.outer", desc = "Move to the end of the previous class" },
        },
      },
      lsp_interop = {
        enable = true,
        -- FIXME: Figure out what border is required here.
        -- border = "",
        peek_definition_code = {
          ["<leader>df"] = { query = "@function.outer", desc = "Peek at the function definition" },
          ["<leader>dF"] = { query = "@class.outer", desc = "Peek at the class definition" },
        },
      },
    },
  })
end

return M
