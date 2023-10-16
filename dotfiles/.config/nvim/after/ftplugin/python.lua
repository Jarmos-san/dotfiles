-- Filetype plugin module for configuring Python development in Neovim
-- Refer to the resource shared below for further inspiration
-- https://github.com/aikow/dotfiles/blob/main/config/nvim/after/ftplugin/python.lua

local opt = vim.opt
local map = require("utils").map

opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- INFO: Local keymap (specific to Python files) to execute the current Python script
map("n", "<F5>", "<CMD>terminal python3 %<CR>")
