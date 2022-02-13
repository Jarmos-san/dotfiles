--[[
Module for configuring Neovim keymaps.
Make changes here to configure your generic custom keymaps
--]]

local map = require('core.utils').map


-- Set <Leader> to <Space>
vim.g.mapleader = ' '

-- Pressing two <Space> simulataneously switches between buffers
map('n', '<Leader><Leader>', ':b#<CR>')

-- Easier navigation between splits
map('n', '<C-j>', '<C-w>j', { noremap = false })
map('n', '<C-k>', '<C-w>k', { noremap = false })
map('n', '<C-h>', '<C-w>h', { noremap = false })
map('n', '<C-l>', '<C-w>l', { noremap = false })

-- Use "Alt = 'Vim Navigation'" to resize windows
map('n', '<M-j>', '<Cmd>resize -2<CR>')
map('n', '<M-k>', '<Cmd>resize +2<CR>')
map('n', '<M-h>', '<Cmd>vertical resize -2<CR>')
map('n', '<M-l>', '<Cmd>vertical resize +2<CR>')

-- Improved "quality of life" when navigating around a single line
map('n', 'H', '<Home>')     -- Press H (capital) to move to the start of the line
map('n', 'L', '<End>')      -- Press L (capital) to move to the end of the line
map('n', 'Y', 'y$')         -- Press Y (capital) to copy the entire line

-- Navigating around while in "Insert" mode
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-h>', '<Left>')
map('i', '<C-l>', '<Right>')

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

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

