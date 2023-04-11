-- Module for configuring the in-built Treesitter capabilities

return {
  {
    "nvim-treesitter/nvim-treesitter", -- Plugin for better syntax highlighting & much more!
    build = function() -- Command to invoke after installing the plugin.
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    event = { "BufReadPost", "BufNewFile" }, -- Lazy-load the plugin only on certain events
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor", -- Rename stuff with the power of Treesitter!
      "JoosepAlviste/nvim-ts-context-commentstring", -- Plugin for better commenting on JSX/TSX files.
      "mrjones2014/nvim-ts-rainbow", -- Extension of bracket colours.
      "windwp/nvim-ts-autotag", -- Extension for automatic HTML tag completion.
      "nvim-treesitter/nvim-treesitter-textobjects", -- Navigate around code blocks more easily with this extension.
      "nvim-treesitter/playground", -- Extension for visualising the Treesitter nodes & graph.
    },
    config = function ()
      require('configs.treesitter').setup() -- Load the module which container some configuration & the parsers to install
    end
  },
}
