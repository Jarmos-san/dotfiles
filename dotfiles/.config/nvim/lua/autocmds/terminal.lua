-- This module defines lifecycle behaviour for Neovim terminal buffers in order
-- to provide a streamlined and predictable terminal experience.

-- Ensure the terminal is already in insert mode when one is opened. This saves
-- a few key presses.
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Get into Insert mode when the terminal is opened",
  group = vim.api.nvim_create_augroup("terminal_insert", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.cmd("startinsert | 1")
  end,
})

-- Close the terminal buffer when its interactive shell process exits. This
-- saves a few key presses as well
vim.api.nvim_create_autocmd("TermClose", {
  desc = "Delete the terminal buffer when the process exits",
  group = vim.api.nvim_create_augroup("terminal_close", { clear = true }),
  callback = function()
    vim.cmd("bdelete")
  end,
})
