-- Module for configuring some of the "mini.nvim" set of plugins

return {
  {
    "echasnovski/mini.trailspace", -- Plugin to visualise trailing whitespaces
    event = "InsertLeave", -- Only load the plugin when leaving Insert mode
    config = function()
      require("mini.trailspace").setup() -- Initialise the plugin with defaults
    end,
  },

  {
    "echasnovski/mini.comment", -- Plugin for easier commenting across source code
    event = "VeryLazy", -- Not sure what this event is about but it works any way!
    opts = {
      hooks = {
        pre = function()
          -- Necessary hook for commenting source code based on Treesitter queries.
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      -- Initialise the plugin for usage across buffers.
      require("mini.comment").setup(opts)
    end,
  },

  {
    "echasnovski/mini.indentscope", -- Plugin to visualise & animate indent lines
    event = "BufReadPost", -- Lazy load the plugin only after the buffer is read
    config = function()
      require("mini.indentscope").setup({
        -- Disable the animation of the indent line visualisation
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })
    end,
  },

  {
    "echasnovski/mini.pairs", -- Plugin for automatically inserting bracket pairs
    event = "InsertEnter", -- Load the plugin only when entering Insert mode.
    opts = {
      modes = {
        insert = true, -- Enable insert bracket pairs automatically in Insert mode
        command = true, -- Enable bracket pair insertion in Command mode
        terminal = true, -- Enable bracket pair insertion in Terminal mode
      },
    },
    config = function(opts) -- Initialise the plugin with the configurations mentioned above
      require("mini.pairs").setup(opts)
    end,
  },
}
