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

-- INFO: Unsure about its use case & quirks, so needs a more thorough research.
-- Restores the cursor to the last position upon repopening a file.
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	desc = "Restores the cursor to the last position upon reopening a file.",
-- 	group = vim.api.nvim_create_augroup("bufcheck", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 			vim.fn.setpos(".", vim.fn.getpos("'\""))
-- 			vim.api.nvim_feedkeys("zz", "n", true)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start git messages in Insert mode",
  group = vim.api.nvim_create_augroup("git_insert", { clear = true }),
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Write all unsaved buffers when focus is lost",
  group = vim.api.nvim_create_augroup("save_buffers", { clear = true }),
  pattern = "*",
  command = "silent! wall",
})

-- INFO: Has some quirks which can mess up when working with certain filetypes like Markdown.
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	desc = "Strip trailing whitespace on save.",
-- 	group = vim.api.nvim_create_augroup("strip_whitespace", { clear = true }),
-- 	pattern = "*",
-- 	command = "%s/\\s\\+$//e",
-- })
