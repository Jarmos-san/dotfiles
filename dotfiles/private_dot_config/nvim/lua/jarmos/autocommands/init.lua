--[
-- =================================================================================
-- Setup some necessary autocommands to load when Neovim starts.
-- =================================================================================
--]

-- Yank on highlight.
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight the yanked text for a specified time.",
  group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- FIXME: Uncomment this later on since it causes issues while in development.
-- Source the "init.lua" file on save.
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Source the 'init.lua' file on save.",
  group = vim.api.nvim_create_augroup("source_init_file", { clear = true }),
  pattern = vim.fn.expand("~/.config/nvim/lua/**/*.lua"),
  command = "source init.lua | PackerCompile",
})

-- Disable colour schemes to change the background colour.
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Disable colorschemes to set/change the background colours.",
  group = vim.api.nvim_create_augroup("disable_colourscheme_background", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd([[ highlight Normal ctermbg=None ]])
  end,
})
