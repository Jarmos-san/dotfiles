--[[
Module for core settings to configure Neovim
Change the settings here to configure Neovim for your specific needs
--]]

local opt = vim.opt -- Alias to setup Neovim options

-- Miscellaneous Neovim stuff that cant be programmed with native Lua code yet {{{2
vim.cmd([[ colorscheme gruvbox ]])
vim.cmd([[ highlight Normal guibg=NONE ctermbg=NONE ]])

-- Indentation configs
opt.expandtab = true -- Use Spaces instead of tabs when <Tab> is pressed
opt.shiftwidth = 4 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.tabstop = 4 -- Number of spaces press a single <Tab> counts for
opt.softtabstop = 4
opt.shiftround = true -- Round indent

-- Display & Improved Quality of Life {{{2
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 6
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.numberwidth = 2
opt.cursorline = true
opt.wrap = false -- Disables wrapping text globally
opt.showmode = false
opt.lazyredraw = true
opt.emoji = false
opt.list = true -- Show invisible characters
opt.listchars = {
	eol = "↲",
	tab = "→ ",
	extends = "…",
	precedes = "…",
	trail = "·",
}
opt.shortmess:append("I") -- Disables the startup screen & info
opt.iskeyword:prepend({ "-" }) -- Treat dash-separated words as a single word textobject

-- Backup configs {{{2
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = false
opt.confirm = true -- Ask for confirmation before any destructive actions

-- Window Splitting & Buffer management {{{2
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.fillchars = {
	vert = "│",
	fold = " ",
	diff = "-", -- alternatives: ⣿ ░
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- Wild & File-globbing patterns {{{2
opt.pumblend = 7 -- Make popup window transclucent
opt.pumheight = 20 -- Limit the number of autocomplete items shown
