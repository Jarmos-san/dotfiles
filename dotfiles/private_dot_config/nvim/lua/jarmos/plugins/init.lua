vim.cmd([[ packadd packer.nvim ]])

local status, packer = pcall(require, "packer")

if not status then
  print("Packer not installed!")
  return
end

packer.startup({
  function(use)
    use({
      -- Allow "packer.nvim" to keep itself updated!
      "wbthomason/packer.nvim",
      opt = true,
      -- Only lazy-load the plugin when the following commands are invoked!
      cmd = { "PackerSync", "PackerCompile", "PackerInstall", "PackerUpdate", "PackerSnapshot" },
    })

    use({
      -- Install a good-looking colorscheme to make it easier to work with.
      "navarasu/onedark.nvim",
      config = function()
        require("jarmos.plugins.onedark").config()
      end,
    })

    -- Install a bunch of plugins for better auto-completion & snippet support.
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("jarmos.plugins.lsp").setup_completions()
      end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
      after = "nvim-lspconfig",
    })

    -- Neccessary plugin for snippet support.
    use({
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      tag = "*", -- Download the latest tagged version of the plugin.
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    })

    -- Install plugin for configuring the LSP client.
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("jarmos.plugins.lsp").setup_lsp()
      end,
    })

    use({
      -- Plugin for installing the various LSP servers.
      "williamboman/mason.nvim",
      config = function()
        require("jarmos.plugins.mason").config()
      end,
    })

    use({
      -- Plugin for auto-installing necessary tools like LSP servers,
      -- formatters, linters & so on.
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("jarmos.plugins.mason").install_servers()
      end,
      cmd = { "MasonToolsUpdate", "MasonToolsInstall" },
    })

    -- Plugin for managing LSP-based diagnostics, code actions & much more capabilities.
    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("jarmos.plugins.null-ls").config()
      end,
      requires = { "nvim-lua/plenary.nvim" },
    })

    -- Plugin for better syntax highlighting & among other goodies!
    use({
      "nvim-treesitter/nvim-treesitter",
      -- FIXME: Lazy-loading it causes a lot of unforeseen issues.
      -- event = { "BufRead", "BufNewFile" },
      run = function()
        require("nvim-treesitter.install").update({
          with_sync = true,
        })
      end,
      config = function()
        require("jarmos.plugins.treesitter").setup()
      end,
      requires = {
        -- Necessary plugin for proper commenting in JSX/TSX files.
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
        -- Treesitter-based plugin for colourising brackets.
        { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
        -- Treesitter-based plugin for automatically inserting/renaming HTML tags.
        { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
        -- Treesitter-based plugin for better navigation around code blocks & text objects.
        { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
        -- Plugin for checking out highlight definitions, proper navigation & better rename capabilities.
        { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
      },
    })

    -- Plugin for easier commenting around the source code based on Treesitter parsing.
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("jarmos.plugins.comment").config()
      end,
      tag = "*", -- Download the latest release instead of the latest breaking changes.
      after = "nvim-ts-context-commentstring",
    })

    -- Treesitter-based plugin for automatic brackets insertion.
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          check_ts = true,
        })
      end,
    })

    -- A more modern file explorer for Neovim which is based on Lua.
    use({
      "nvim-neo-tree/neo-tree.nvim",
      tag = "*", -- Download the latest tagged version instead of the latest commits.
      cmd = { "Neotree" }, -- Lazy-load only when the ":Neotree" command is invoked.
      requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "kyazdani42/nvim-web-devicons" },
        { "MunifTanjim/nui.nvim" },
      },
      config = function()
        require("jarmos.plugins.neotree").config()
      end,
    })

    -- Plugin for visualising the indents & blanklines properly.
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("jarmos.plugins.indent-blankline").config()
      end,
      tag = "*", -- Download the latest tagged version instead of the latest commits.
    })

    -- Configure Neovim to have version-control features.
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("jarmos.plugins.gitsigns").config()
      end,
      tag = "*", -- Download the latest tagged version instead of the latest commits.
      -- FIXME: Configure "gitsigns" to load only when the current working directory is a git repository.
      -- For a detailed discussion on a possible fix, refer to the following thread for more information:
      -- https://neovim.discourse.group/t/how-to-conditionally-load-gitsigns-only-when-current-working-directory-is-a-git-repository/3284
      -- cond = function()
      --     if vim.api.nvim_command_output("!git rev-parse --is-inside-work-tree") == true then
      --         return true
      --     end
      -- end,
    })

    -- TODO: Uncomment the following lines of code after customising it properly.
    -- use({
    --   "rebelot/heirline.nvim",
    --   config = function()
    --     require("jarmos.plugins.heirline").config()
    --   end,
    -- })

    -- TODO: Replace it with "rebelot/heirline.nvim" instead.
    -- Custom statusline with additional features like version-control information.
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
      },
      config = function()
        require("jarmos.plugins.lualine").config()
      end,
    })

    use({
      "jose-elias-alvarez/typescript.nvim",
      ft = { "typescript", "typescriptreact" },
      config = function()
        require("jarmos.plugins.lsp").setup_typescript_lsp()
      end,
    })

    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup()
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("jarmos.plugins.which-key").config()
      end,
    })

    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
      ft = { "scss", "css", "javascript", "typescript", "typescriptreact", "html" },
    })

    -- Plugin for advanced notifications about various stuff.
    use({
      "rcarriga/nvim-notify",
    })

    -- Plugin for providing a floating-window based UI for various functionalities.
    use({
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      config = function()
        require("jarmos.plugins.telescope").config()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "chip/telescope-software-licenses.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      cmd = { "Telescope" },
    })

    -- A more useful UI greeter.
    use({
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("jarmos.plugins.alpha").config()
      end,
      event = { "BufEnter" },
    })

    -- Plugin for improved buffer deletion capabilities.
    use({
      "famiu/bufdelete.nvim",
      cmd = { "Bdelete" },
    })

    -- Plugin for better terminal management right within Neovim.
    use({
      "akinsho/toggleterm.nvim",
      tag = "*",
      config = function()
        require("toggleterm").setup()
      end,
      cmd = { "ToggleTerm" },
    })

    -- Plugin for improving the load times.
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })

    -- Plugin for better navigation around LSP diagnostic errors
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("jarmos.plugins.trouble").config()
      end,
    })

    -- Plugin for better UI/UX within Neovim.
    use({
      "folke/noice.nvim",
      config = function()
        require("jarmos.plugins.noice").config()
      end,
      requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    })
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
    },
    git = {
      default_url_format = "https://hub.fastgit.xyz/%s",
    },
  },
})
