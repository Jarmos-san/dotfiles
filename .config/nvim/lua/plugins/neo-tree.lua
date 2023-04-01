-- Module for configuring the file explorer based on the "neo-tree.nvim" plugin

return {
  {
    "nvim-neo-tree/neo-tree.nvim", -- Plugin to manage & access the file system using an explorer
    cmd = "Neotree", -- Lazy-load the plugin only when the "Neotree" command is invoked
    keys = {
      {
        "<leader>fe", -- Press "Space + f + e" to toggle open/close the file explorer
        function()
          -- Open the file explorer in the current directory.
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Open the Neotree file explorer",
      },
    },
    deactivate = function() -- Callback function to deactivate the plugin when necessary.
      vim.cmd([[ Neotree close]])
    end,
    init = function() -- Initialisation stuff before starting the plugin.
      vim.g.neo_tree_remove_legacy_commands = 1

      if vim.fn.argc() == 1 then -- Check if there's only one file opened with Neovim.
        -- Assign the first file opened with Neovim to the "stat" variable name.
        local stat = vim.loop.fs_stat(vim.fn.argv(0))

        -- Import the "Neotree" plugin module if the "stat" variable is a "directory"
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true, -- Don't leave the plugin's window open as the last window
      enable_git_status = true, -- Enable Git VCS information for the current working directory
      enable_diagnostics = true, -- Enable diagnostic feedback for all files in the working directory
      filesystem = {
        hijack_netrw_behaviour = "open_current", -- Use the plugin instead of the default "netrw" plugin
        bind_to_cwd = false,
        follow_current_file = true,
        filtered_items = {
          never_show = { "node_modules" },
          always_show = {
            ".github",
            ".gitignore",
            ".gitmodules",
            ".gitattributes",
            ".editorconfig",
            ".pre-commit-config.yaml",
          },
        },
      },
      window = {
        width = "25", -- Hard-code the size of the window width
      },
    },
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  },
}
