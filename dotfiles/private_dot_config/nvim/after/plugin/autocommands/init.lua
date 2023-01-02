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

-- INFO: Open the "alpha.nvim" dashboard when the last buffer is also closed/deleted.
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre*",
  group = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true }),
  callback = function(event)
    local fallback_name = vim.api.nvim_buf_get_name(event.buf)
    local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
    local fallback_on_empty = fallback_name == "" and fallback_ft == ""

    if fallback_on_empty then
      vim.cmd("Neotree close")
      vim.cmd("Alpha")
      vim.cmd(event.buf .. "bwipeout")
    end
  end,
})

-- INFO: A bunch of autocommands for creating "skeletons" (see ":h skeleton" for more info on this regards.)
local create_skeleton_group = vim.api.nvim_create_augroup("create_skeletons", { clear = true })

-- INFO: Generate a base template for Dependabot config files.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "**/.github/dependabot.yml",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/dependabot.yml",
})

-- INFO: Generate a base template for "Dockerfile".
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "Dockerfile",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/dockerfile",
})

-- INFO: Generate a bare minimum EditorConfig file.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = ".editorconfig",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/editorconfig",
})

-- INFO: Generate a bare minimum GH Actions workflow file to build upon.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "**/.github/workflows/*.yml",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/gh-action.yml",
})

-- INFO: Generate a bare minimum MIT License template for my personal projects.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "LICENSE",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/license",
})

-- INFO: Template for the "Stale" bot configuration file.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "**/.github/stale.yml",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/stale.yml",
})

-- INFO: Generate a bare minimum template when working on Lua module for configuring Neovim.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "**/nvim/lua/**/*.lua",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/nvim-lua-module.lua",
})

-- INFO: Template for a bare minimum Task config file.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "Taskfile.yml",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/taskfile.yml",
})

-- INFO: Create a template file for "READMEs".
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "README.md",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/readme.md",
})

-- INFO: Generate the template file for Bash/Shell files.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/bash.sh",
})

-- Jumpt to last known location on a file before exiting it. See the following link for information:
-- https://this-week-in-neovim.org/2023/Jan/02#tips
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
