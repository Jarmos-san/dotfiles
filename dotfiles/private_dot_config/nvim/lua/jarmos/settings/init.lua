--[
-- =================================================================================
-- Some bare minimum Neovim configurations to improve the user's quality of life.
-- =================================================================================
--]

-- Disable the following runtine dependencies from loading since they're not necessary.
vim.g.loaded_ruby_provider = false
vim.g.loaded_perl_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_python3_provider = false

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Basic Neovim options which improves my quality of life when writing code.
vim.opt.number = true -- Enable the current row number of the left side.
vim.opt.autoindent = true -- Copy indent from the current line when starting a newline.
vim.opt.smartindent = true -- Make the indents smarter based on the "autoindents".
vim.opt.relativenumber = true -- Enable the number column on the left.
vim.opt.hlsearch = false -- Disable highlighting the searched keyword.
vim.opt.ignorecase = true -- Disable searching for case-specific keywords.
vim.opt.smartcase = true -- Intelligently figure out case-senstivity when looking up keywords.
vim.opt.scrolloff = 10 -- Maintain a buffer of 10 rows when scroll up/down.
-- vim.opt.cursorline = true -- Enables the cursorline which looks ugly without a proper colorscheme.
vim.opt.termguicolors = true -- Enables 24-bit colours (not sure if its required at all).
vim.opt.winblend = 0 -- Controls the transparency of the floating windows. Values range from 0-100.
vim.opt.wildoptions = "pum" -- Display the popup-menu for completions.
vim.opt.pumblend = 5 -- Controls the transparency of the popup-menu which appears during completions.
vim.opt.backup = false -- Disable creating backups before modifying a file.
vim.opt.showcmd = true -- Enable showcasing the current invoked command.
vim.opt.cmdheight = 1 -- Not sure what it does or how it helps. (lol?)

-- There's too much I don't understand about configuring Tab/Space indents in Neovim.
-- See the following SO thread for a detailed explanation:
-- https://stackoverflow.com/a/1878983/8604951
vim.opt.tabstop = 4 -- Insert 4 Spaces when a single Tab is pressed.
vim.opt.softtabstop = 0 -- Magic!!
vim.opt.shiftwidth = 4 -- More magic!!
vim.opt.expandtab = true -- Insert appropriate number of Spaces when a <Tab> is pressed.
vim.opt.smarttab = true -- Insert Spaces when a <Tab> is pressed.

vim.opt.breakindent = true -- Wrap every line with proper indents.
vim.opt.backspace = { "start", "eol", "indent" } -- Perform appropriate actions when <Backspace> is pressed.
vim.opt.path:append({ "**" }) -- Search down subfolders when looking for files.
vim.opt.wildignore:append({ "**/node_modules/*" }) -- Ignore set of files & folders.

vim.opt.list = true -- Show invisible characters like whitespace in a buffer.

vim.g.mapleader = " " -- Remap the leader to "Space".
-- Assign what each type of whitespace should look like.
-- FIXME: It still doesn't work as I expect it to.
vim.opt.listchars = {
  eol = "↴",
  tab = "→ ",
  -- space = "·",
  extends = "…",
  precedes = "…",
  trail = ".",
}

vim.g.completeopt = { "menu", "menuone", "noselect" }
