local utils = require('utils')  -- Utility wrapper functions

local fn = vim.fn               -- Alias to execute Neovim-specific functions
local opt = vim.opt             -- Alias to setup Neovim options
local cmd = vim.cmd             --Alias for vim.cmd

local execute = vim.api.nvim_command

local map = utils.map

-- Genereic Neovim Configurations
-- Indentation configs
opt.expandtab = true            -- Use spaces instead of tabs when <Tab> is pressed
opt.shiftwidth = 4              -- Size of an indent
opt.smartindent = true          -- Inserts indents automatically
opt.tabstop = 4                 -- Number of spaces press a single <Tab> counts for
opt.softtabstop = 4
opt.shiftround = true           -- Round indent

-- Display & improved QoL
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 6
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.numberwidth = 2
opt.cursorline = true
opt.wrap = false
opt.showmode = true             -- Will change it to "false" later on
opt.lazyredraw = true
opt.emoji = false
opt.list = true
opt.fillchars = {
    vert = '│',
    fold = ' ',
    diff = '-', -- alternatives: ⣿ ░
    msgsep = '‾',
    foldopen = '▾',
    foldsep = '│',
    foldclose = '▸',
}

-- Miscellaneous Neovim stuff which can't be configured with native Lua code yet
cmd [[ colorscheme gruvbox ]]
cmd [[ highlight Normal guibg=None ctermbg=None ]]

-- Plugins installation & configurations
local packer_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

--Ensure if local clone of 'packer.nvim' exists
if fn.empty(fn.glob(packer_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim' .. ' ' .. packer_path)
end

cmd [[ packadd! packer.nvim ]]

local packer = require('packer')
local use = packer.use

-- Install rest of the required plugins
packer.startup(function()

    use { -- Install packer.nvim itself
        'wbthomason/packer.nvim',
        opt = true
    }

    use { -- Plugin for toggling comments on/off
        'b3nj5m1n/kommentary',
        event = { 'BufRead', 'BufNewFile' },
        config = require('conf.kommentary').config
    }

    use { -- File explorer plugin
        'kyazdani42/nvim-tree.lua',
        opt = true,
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
        setup = function()
            require('conf.nvim_tree').setup()
        end,
        config = function()
            require('conf.nvim_tree').config()
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use { -- Visualize indents & whitespace
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufRead', },
        config = require('conf.indentline').config
    }
end)

-- Global configurations related to plugins
vim.g.gruvbox_contrast_dark = "hard"
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.netrw_menu = 0

-- Key mappings
vim.g.mapleader = ' '

-- Pressing two <Space> switches between buffers
map('n', '<Leader><Leader>', ':b#<CR>')

-- Easier navigation between splits
map('n', '<C-j>', '<C-w>j', { noremap = false })
map('n', '<C-k>', '<C-w>k', { noremap = false })
map('n', '<C-h>', '<C-w>h', { noremap = false })
map('n', '<C-l>', '<C-w>l', { noremap = false })

-- TODO: Resizing mappings

-- Improved QoL when navigating lines of code
map('n', 'H', '<Home>')
map('n', 'L', '<End>')
map('n', 'Y', 'y$')

-- Navigating around while in "Insert" mode
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-h>', '<Left>')
map('i', '<C-l>', '<Right>')

-- Press "Ctrl + a" to select everything in a buffer
map('n', '<C-a>', '<Esc>ggVG<CR>')

-- Some sensible defaults
map('', 'Q', '<NOP>')       -- Disable Ex mode as I can't think of any ways to use it
map('n', 'x', '"_x')        -- Delete characters w/o yanking it
map('x', 'x', '"_x')        -- Delete visual selection w/o yanking

-- Disable arrow keys for learning Vim movements
map('', '<Up>', '<NOP>')
map('', '<Down>', '<NOP>')
map('', '<Left>', '<NOP>')
map('', '<Right>', '<NOP>')

-- Disable arrow keys in Insert mode as well
map('i', '<Up>', '<NOP>')
map('i', '<Down>', '<NOP>')
map('i', '<Left>', '<NOP>')
map('i', '<Right>', '<NOP>')

-- Remap "jk" to "<Esc>" to change into Normal mode
map('i', 'jk', '<Esc>')

-- Edit & source the "init.lua" file more intuitively
map('n', '<Leader>v', ':edit $MYVIMRC<CR>')
map('n', '<Leader>s', ':luafile $MYVIMRC<CR>')
