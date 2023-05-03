-- Module which lazy.nvim automatically uses to manage the Neovim plugins.
-- Its does not need to be manually reloaded nor sourced. See the docs below for more information on this regards:
-- https://github.com/folke/lazy.nvim#-structuring-your-plugins

-- TODO: Move all the plugins from the "lua/plugins" folder over here instead

-- TODO: Explore the following plugins & decide to use them or not
-- "JellyApple102/flote.nvim", -- Plugin to take simple & disposable Markdown notes
-- "echasnovski/mini.starter", -- Plugin to show a nice, simple & minimal startup screen and a dashboard
-- "echanovski/mini.bufremove" -- Simple plugin to remove/delete buffers
-- "echanovski/mini.move"  -- Plugin to move a selected text object around in any direction
-- "echanovski/mini.splitjoin"  -- Plugin to split & join a list of arguments properly

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

local plugins = {
  {
    -- Plugin for deleting & removing buffers without messing up the window layout
    "famiu/bufdelete.nvim",
    -- Load the plugin right before the current buffer is about to be deleted.
    event = "BufEnter",
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
      disabled_filetypes = require("configs.smartcolumn").disable_filetypes,
      -- Configure the character length at which to show the colorcolumn.
      custom_colorcolumn = require("configs.smartcolumn").filetype_column_width,
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
      autocmd("TermOpen", {
        desc = "Get into Insert mode automatically when the terminal is open",
        group = augroup("terminal_insert_mode"),
        callback = function(args)
          if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
            vim.cmd("startinsert")
          end
        end,
      })

      -- Disable the number column & enable some highlights for the terminal
      autocmd("TermOpen", {
        desc = "Disable number coloum on the terminal",
        group = augroup("terminal_highlights"),
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
    event = "BufRead",
    cmd = { "Telescope" },
    opts = {
      file_ignore_patterns = { "%.git", "node_modules", "venv", ".venv", "env", ".env" },
    },
    config = true,
    -- These dependencies (some of these are optional) are necessary for proper functioning of the plugin
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    -- Plugin for showing nice popup UI, can be used in conjunction with LSP & others
    "rcarriga/nvim-notify",
    -- Lazy load the plugin after the contents of the buffer are read
    event = "BufRead",
    opts = {
      -- Set the background colour since the main Neovim background is transparent
      background_colour = "#262626",
      -- Set the maximum width & height a notification bar can occupy to avoid clutter
      max_width = 60,
      max_height = 40,
      -- Set the animation to something subtle to avoid distractions
      stages = "fade",
    },
    -- Initialise the plugin with some configurations AFTER its loaded
    config = function(opts)
      require("notify").setup(opts)

      -- Configure Neovim's notification capabilities to use the plugin instead
      vim.notify = require("notify")
    end,
  },

  {
    -- Plugin for quickly visualising Git VCS info right within the buffer
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = true,
  },

  {
    -- Plugin to showcase the color code based on Hex/RGB/HSL & more
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    ft = { "typescriptreact", "typescript", "javascript", "javascriptreact", "scss", "css", "html" },
  },

  {
    -- Plugin to manage & access the file system using an explorer
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree", -- Lazy-load the plugin only when the "Neotree" command is invoked
    deactivate = function() -- Callback function to deactivate the plugin when necessary.
      vim.cmd([[ Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      local highlight = vim.api.nvim_set_hl

      -- Autocommand to highlight the current line if the buffer is a "neo-tree" filetype
      autocmd("FileType", {
        pattern = "neo-tree,*",
        group = augroup("highlight_cursorline"),
        callback = function()
          -- FIXME: Configure the plugin to highlighting the current line for accessiblity concerns
          highlight(0, "CursorLine", { ctermfg = nil, ctermbg = "White" })
        end,
      })

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
    config = true,
    opts = {
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
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  {
    -- Plugin to load JSON schemas
    "b0o/schemastore.nvim",
    event = "BufRead",
    ft = "json",
  },

  {
    -- Plugin which provides some extra keybinds for easier navigation
    "chrisgrieser/nvim-various-textobjs",
    event = "BufRead",
    -- Use the plugin with default keymappings
    opts = { useDefaultKeymaps = true },
    config = true,
  },

  {
    -- Plugin for better Rust LSP support & more
    "simrat39/rust-tools.nvim",
    event = "BufRead",
    ft = "rust",
  },

  {
    -- Plugin for better TypeScript LSP support & more
    "jose-elias-alvarez/typescript.nvim",
    event = "BufRead",
    -- Load the plugin only when working on TypeScript projects
    ft = { "typescript", "typescriptreact" },
  },

  {
    -- Plugin to automatically insert HTML/JSX tags where necessary
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    -- Load the plugin only for webdev project files
    ft = { "typescriptreact", "javascriptreact", "html" },
  },

  {
    -- Plugin for configuring a nice looking statusline
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local options = {
        -- Leaving an empty table renders the square-edged components, else the default angled ones are loaded
        section_separators = {},
        component_separator = "|",
        theme = "onedark", -- Set the theme
        globalstatus = true,
        disabled_filetypes = { -- Disable the statusline for certain filetypes mentioned below
          statusline = {
            "filesytem",
            "neo-tree",
            "dashboard",
            "lazy",
            "alpha",
            "null-ls-info",
            "lspinfo",
            "mason",
            "neo-tree-popup",
          },
        },
      }

      local sections = {
        -- Statusline components to showcase on the right-most end
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }

      require("lualine").setup({ options = options, sections = sections })
    end,
  },

  {
    -- The default colorscheme used right now
    "navarasu/onedark.nvim",
    -- Load the colorscheme right after the "nvim" command is invoked
    event = "VimEnter",
    -- Configure the colorscheme according to personal preferences
    opts = {
      style = "darker",
      transparent = true,
      lualine = { transparent = true },
    },
  },

  {
    -- Plugin for better (un)commenting of code
    "echasnovski/mini.comment",
    -- Load the plugin only after the contents of a buffer are read or a new file
    -- is created with some contents in the buffer
    event = { "BufNewFile", "BufRead" },
    opts = {
      -- Ensure blanklines don't have unnecessary comments to avoid clutter
      ignore_blank_lines = true,
      hooks = {
        pre = function()
          -- Necessary hook for commenting source code based on Treesitter queries.
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(opts)
      -- Configure the plugin with the configuration options provided above
      require("mini.comment").setup(opts)
    end,
  },

  {
    -- Simple & minimal plugin for pairing brackets, quotes & more!
    "echasnovski/mini.pairs",
    -- Load the plugin only after entering Insert mode
    event = "InsertEnter",
    opts = {
      -- Enable some extra modes where this plugin should be useable
      modes = {
        insert = true, -- "Insert" mode
        command = true, -- "Command" mode
        terminal = true, -- "Terminal" mode
      },
    },
    config = function(opts)
      -- Configure the plugin with the configuration options provided above
      require("mini.pairs").setup(opts)
    end,
  },

  {
    -- Plugin for easier insertion of pairs like quotations & more
    "echasnovski/mini.surround",
    -- Load the plugin only after the contents of the buffer are read
    event = "BufReadPost",
    config = function()
      -- Initialise the plugin with default settings
      require("mini.surround").setup()
    end,
  },

  {
    -- Plugin to visualise indentation of source code in a better way
    "echasnovski/mini.indentscope",
    -- Load the plugin only after the contents of the buffer are read
    event = "BufRead",
    config = function()
      -- Configure the plugin with default settings
      require("mini.indentscope").setup()
    end,
  },

  {
    -- Plugin to load a nice dashboard with utilities in the startup screen
    "goolord/alpha-nvim",
    -- Load the plugin after the initial UI is loaded
    event = "VimEnter",
    init = function()
      autocmd("User", {
        desc = "Open Alpha dashboard when all buffers are removed",
        group = augroup("open_alpha_on_buffer_removal"),
        pattern = "BDeletePost*",
        callback = function(event)
          local fallback_name = vim.api.nvim_buf_get_name(event.buf)
          local fallback_filetype = vim.api.nvim_buf_get_option(event.buf, "filetype")
          local fallback_on_empty = fallback_name == "" and fallback_filetype == ""

          if fallback_on_empty then
            vim.cmd("Neotree close")
            vim.cmd("Alpha")
            vim.cmd(event.buf .. "bwipeout")
          end
        end,
      })
    end,
    -- Load the plugin configurations
    config = function()
      -- Load a default provided dashboard for easy access to recently opened files
      local dashboard = require("alpha.themes.dashboard")
      require("alpha").setup(dashboard.config)
    end,
    -- List of dependencies for the plugin
    dependencies = "kyazdani42/nvim-web-devicons",
  },

  {
    -- A friendly plugin for managing the LSP servers more easily.
    "williamboman/mason.nvim",
    -- Lazy-load the plugin only when this command is invoked.
    cmd = "Mason",
    -- Configuration options which will be passed to the config key when the plugin will be initialised
    opts = {
      -- Configure the plugin to have rounded borders
      ui = { border = "rounded" },
      -- Configure the log levels for the plugin
      log_level = vim.log.levels.WARN,
    },
    -- Initialise the plugin
    config = true,
    -- Load this dependency when the plugin is loaded as well.
    dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  {
    -- Extension for "mason.nvim" which makes it VERY easy to auto-install LSP servers.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Lazy-load the extension only when these commands are invoked.
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    -- Initialisation function to invoke right before the plugin is loaded
    init = function()
      autocmd("User", {
        pattern = "MasonToolsUpdateComplete",
        desc = "Invoke a notification when Mason has completed installing/updating the servers",
        group = augroup("mason_notifications"),
        callback = function()
          vim.schedule(function()
            vim.notify("Mason has completed installing the servers...")
          end)
        end,
      })
    end,
    -- Load the list of LSP servers for Mason to download & install
    opts = require("configs.mason").mason_packages,
    config = function(opts)
      -- Load the plugin with the list of packages imported above
      require("mason-tool-installer").setup(opts)
    end,
  },
}

return plugins
