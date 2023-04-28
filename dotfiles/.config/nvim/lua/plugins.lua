-- Module which lazy.nvim automatically uses to manage the Neovim plugins.
-- Its does not need to be manually reloaded nor sourced. See the docs below for more information on this regards:
-- https://github.com/folke/lazy.nvim#-structuring-your-plugins

-- TODO: Move all the plugins from the "lua/plugins" folder over here instead

-- Module containing configuration options for the colour column plugin ("m4xshen/smartcolumn.nvim")
local smartcolumn_options = require("configs.smartcolumn")

local plugins = {
  {
    -- Plugin for deleting & removing buffers without messing up the window layout
    "famiu/bufdelete.nvim",
    -- Load the plugin right before the current buffer is about to be deleted.
    event = "BufDelete",
  },

  {
    -- Plugin for a better & quicker "Escape" mechanism.
    "max397574/better-escape.nvim",
    -- Load the plugin right before leaving Insert mode.
    event = "InsertLeavePre",
  },

  {
    -- Plugin to enable a smoother scroll animation
    "karb94/neoscroll.nvim",
    -- Load the plugin only after the contents of the buffer are read.
    event = "BufRead",
    -- Initialise the plugin with some configurations
    opts = {
      -- Respect the scrolloff marging (see ":h scrolloff" for more info)
      respect_scrolloff = true,
      -- Stop the cursor from scrolling further if the window cannot scroll any more.
      cursor_scrolls_alone = false,
    },
  },

  {
    -- Functionally better plugin for showing a nice colorcolum
    "m4xshen/smartcolumn.nvim",
    -- Load the plugin only when the filetype of the buffer is recognised.
    event = "FileType",
    -- Initialise the plugin with some configurations for easier readability & usability
    opts = {
      -- Disable the colorcolum in certain filetypes like vimdoc & certain configuration files.
      disabled_filetypes = smartcolumn_options.disable_filetypes,
      -- Configure the character length at which to show the colorcolumn.
      custom_colorcolumn = smartcolumn_options.filetype_column_width,
    },
  },

  {
    -- A better functioning & minimal terminal for usage within Neovim itself
    "rebelot/terminal.nvim",
    -- Ensure the plugin is only loaded when the following commands are invoked (can even be invoked through a keymap)
    cmd = { "TermOpen", "TermRun" },
    -- Initialisation callback which is invoked right before the plugin is loaded
    init = function()
      -- Autocommand to ensure the Neovim gets into Insert mode automatically when
      -- the terminal is toggled open.
      vim.api.nvim_create_autocmd("TermOpen", {
        desc = "Get into Insert mode automatically when the terminal is open",
        group = vim.api.nvim_create_augroup("terminal_insert_mode", { clear = true }),
        callback = function(args)
          if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
            vim.cmd("startinsert")
          end
        end,
      })

      -- Disable the number column & enable some highlights for the terminal
      vim.api.nvim_create_autocmd("TermOpen", {
        desc = "Disable number coloum on the terminal",
        group = vim.api.nvim_create_augroup("terminal_highlights", { clear = true }),
        callback = function()
          -- Disable the number column in the terminal
          vim.opt.number = false
          vim.opt.relativenumber = false
          -- Set some highlightings for the floating window
          vim.api.nvim_win_set_option(0, "winhl", "Normal:NormalFloat")
        end,
      })
    end,
    -- Some initialisation options like the shell to use & so on to load the plugin with
    config = function()
      require("terminal").setup({
        -- Close the terminal as well when the shell process is exited
        autoclose = true,
      })
    end,
  },

  {
    -- A UI plugin for registering and managing keymaps under a single place
    "folke/which-key.nvim",
    -- Lazy load the plugin after the initial Neovim UI is loaded
    event = "VeryLazy",
    -- Load the plugin with a couple of initialisation parameters
    config = function()
      -- Enable Neovim to wait a couple of milliseconds after a key is pressed to trigger the plugin
      vim.o.timeout = true
      -- Configure a high enough timeout length so that the plugin does not trigger all the time
      vim.o.timeoutlen = 500
      require("which-key").setup({
        -- A list of plugins & their configurations (only the default ones are used, for now)
        plugins = {
          -- Disable the "spelling" plugin since it can be annoying at times
          spelling = { enabled = false },
        },
        -- Configure the floating window to have a window for clearly distinguishing between which is what
        window = { border = "single" },
        -- Disable showing keymaps w/o any descriptions to avoid unnecessary clutter
        ignore_missing = true,
      })
    end,
  },

  {
    -- Plugin to display the diagnostic messages in a floating window
    "folke/trouble.nvim",
    -- Lazy load the plugin only when an LSP server is attached to the client and/or when its
    -- respective command is called
    event = { "LspAttach" },
    cmd = { "Trouble" },
    -- Initialise the plugin with some default configurations
    config = true,
    -- Dependency plugin for Nerd Font icon support
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  {
    -- Plugin to easily search for files using fuzzy-search & more behaviour like one would find
    -- one other GUI Text Editors like VSCode & so on
    "nvim-telescope/telescope.nvim",
    -- Lazy-load the plugin after the initial UI is loaded by Neovim and/or when the relevant
    -- commands are called for it
    event = { "BufRead" },
    cmd = { "Telescope" },
    -- Initialise the plugin with default settings
    -- FIXME: Opens the Telescope UI after the buffer is loaded which is an unintended behaviour.
    -- config = function()
    --   Configure Telescope to list version-controlled files in a Git directory else fallback
    --   to OG listing the contents of a directory.
    --   Picked the code snippet from the official documentations at the following URL:
    --   https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
    --   local opts = {}
    --   vim.fn.system("git rev-parse --is-inside-work-tree")
    --   if vim.v.shell_error == 0 then
    --     require("telescope.builtin").git_files(opts)
    --   else
    --     require("telescope.builtin").find_files(opts)
    --   end
    -- end,
    -- These dependencies (some of these are optional) are necessary for proper functioning of the plugin
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}

return plugins
