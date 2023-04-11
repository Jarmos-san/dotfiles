local M = {}

-- Configurations for customisation the look/behaviour of the Neotree plugin
local options = {
  close_if_last_window = true, -- Don't leave the plugin's window open as the last window
  enable_git_status = true, -- Enable Git VCS information for the current working directory
  enable_diagnostics = true, -- Enable diagnostic feedback for all files in the working directory
  filesystem = {
    hijack_netrw_behaviour = "open_current", -- Use the plugin instead of the default "netrw" plugin
    bind_to_cwd = false,
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = { ".git", ".null-ls_*" },
    },
  },
  window = {
    width = "30", -- Hard-code the size of the window width
  },
}

M.keys = {
  -- Table of keybinds for the Neo-Tree plugin
  {
    "<Leader>fe",
    function()
      require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    end,
  },
}

-- Initialisation function for the plugin which is loaded first thing before everything else
M.init = function()
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
end

-- Setup the plugin with the configurations shared above
M.setup = function()
  require("neo-tree").setup(options)
end

return M
