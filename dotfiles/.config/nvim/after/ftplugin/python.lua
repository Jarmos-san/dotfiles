-- Filetype plugin module for configuring Python development in Neovim
-- Refer to the resource shared below for further inspiration
-- https://github.com/aikow/dotfiles/blob/main/config/nvim/after/ftplugin/python.lua

local opt = vim.opt

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local map = require("utils").map
local format = require("utils").format

opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- INFO: Local keymap (specific to Python files) to execute the current Python script
map("n", "<F5>", "<CMD>terminal python3 %<CR>")

autocmd("BufWritePost", {
  desc = "Format buffer contents after writing them",
  group = augroup("format_python_files"),
  callback = function()
    -- INFO: Command to invoke black from within Neovim
    local black_command = "silent !black % --stdin-filename % --quiet"

    -- INFO: Run the formatting command on the buffer contents
    format(black_command)

    -- INFO: If "black" exited with an error, undo the changes to the previous state
    if not vim.g.shell_error == 0 then
      vim.cmd("undo")
    end
  end,
})
