-- Module for configuring and managing the "mini.nvim" plugins

return {
  {
    "echasnovski/mini.comment",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      -- FIXME: Blank lines are also commented (need a fix someday)
      ignore_blank_lines = true,
      custom_commentstring = function()
        return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      end,
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },

  {
    "echasnovski/mini.pairs",
    event = { "CmdwinEnter", "InsertEnter" },
    opts = {
      modes = {
        insert = true, -- "Insert" mode
        command = true, -- "Command" mode
        terminal = true, -- "Terminal" mode
      },
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "BufReadPost",
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    config = function()
      require("mini.indentscope").setup()
    end,
  },

  {
    "echasnovski/mini.bufremove",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mini.bufremove").setup()
    end,
  },

  {
    -- Plugin to show a nice, minimal and easy-to-use startup screen
    "echasnovski/mini.starter",
    event = "VimEnter",
    opts = function()
      local header = "Hello World!"
      return {
        items = {
          { name = "Open Old Files", action = "Telescope oldfiles", section = "File Explorer" },
          { name = "Open File Explorer", action = "Neotree toggle", section = "File Explorer" },
          { action = require("mini.starter").sections.recent_files(8, true, true), section = "Recent Files" },
          { name = "Fuzzy Search for Files/Folders", action = "Telescope find_files", section = "File Explorer" },
        },
        header = header,
        footer = 'Press "alt + j/k" to navigate up/down.',
      }
    end,
    config = function(_, opts)
      require("mini.starter").setup(opts)
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    event = "BufReadPost",
    config = function()
      require("mini.splitjoin").setup()
    end,
  },

  {
    "echasnovski/mini.move",
    event = "BufReadPost",
    config = function()
      require("mini.move").setup()
    end,
  },
}
