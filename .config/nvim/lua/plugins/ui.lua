-- Module for configuring various UI enhancements to give Neovim a more modern look & feel

return {
  {
    "rcarriga/nvim-notify", -- Plugin for showing nice popup UI, can be used in conjunction with LSP & others
    event = "VimEnter", -- Ensure the plugin is loaded after entering the Neovim UI
    config = function()
      require("notify").setup({
        background_colour = "#262626", -- Set the background colour since the main Neovim background is transparent
        max_width = 60, -- Set the maximum width a notification bar can occupy so as to not clutter the screen too much
        max_height = 40, -- Set the maximum height for the notification message to occupy
        stages = "fade", -- Set the animation to something subtle to avoid distractions
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim", -- Plugin for quickly visualising Git VCS info right within the buffer
    -- Conditionally load this plugin only if the current working directory is a local Git repo
    cond = function()
      if
        not vim.loop.fs_stat(vim.loop.cwd() .. "./git") -- Check if the current directory has the ".git" folder
        -- Additionally, double-check with Git to see if the local repo IS actually a Git repo
        and vim.fn.system({ "git", "rev-parse", "--show-level", "2>", "/dev/null" })
      then
        -- If both the conditions mentioned above fail, then return "false" for Lazy to not load the plugin
        return false
      end
    end,
  },
}
