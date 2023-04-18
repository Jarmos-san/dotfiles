-- Module for configuring the file explorer based on the "neo-tree.nvim" plugin

return {
  {
    "nvim-neo-tree/neo-tree.nvim", -- Plugin to manage & access the file system using an explorer
    cmd = "Neotree", -- Lazy-load the plugin only when the "Neotree" command is invoked
    keys = require("configs.neo-tree").keys,
    deactivate = function() -- Callback function to deactivate the plugin when necessary.
      vim.cmd([[ Neotree close]])
    end,
    init = require("configs.neo-tree").init(),
    config = function()
      require("configs.neo-tree").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
}
