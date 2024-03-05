-- Module to configure the "neotree" plugin for file management capabilities

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[ Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    -- Check if there's only one file opened with Neovim
    if vim.fn.argc() == 1 then
      -- Assign the first file opened with Neovim to the "stat" variable
      local stat = vim.loop.fs_stat(vim.fn.argv(0))

      -- Import the "Neotree" module if the "stat" variable is a directory
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
      follow_current_file = {
        enable = true,
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = {
          ".coverage",
          ".git",
          ".mypy_cache",
          "node_modules",
          ".pytest_cache",
          ".ruff_cache",
          ".task",
          ".terraform",
          ".terraform.lock.hcl",
          ".tmp",
          ".venv",
          "__pycache__",
        },
        hide_by_name = { "__init__.py" },
        always_show = { ".env" },
      },
    },
    window = {
      width = "50", -- Hard-code the size of the window width
      position = "right",
    },
    config = function(_, opts)
      require("neotree").setup(opts)
    end,
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "devicons",
    "MunifTanjim/nui.nvim",
  },
}
