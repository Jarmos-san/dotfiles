-- Module for configuring some global autocommand which will always be loaded at startup

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("TextYankPost", {
  desc = "Highlight the yanked text for a specified time.",
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 }) -- Keep the highlight for 250ms after yanking.
  end,
})

autocmd("FileType", {
  desc = "When opening Git commit messages, start the buffer in Insert mode",
  group = augroup("git_insert"),
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

autocmd("TermOpen", {
  desc = "Get into Insert mode when the terminal is opened",
  group = augroup("terminal_insert"),
  command = "set nonumber | set norelativenumber | startinsert | 1",
})

autocmd("FocusLost", {
  desc = "Save/write all unsaved buffers when focus is lost",
  group = augroup("save_buffers"),
  pattern = "*",
  command = "silent! wall",
})

autocmd("BufReadPost", {
  desc = "Jump to the last known position of a file before closing it",
  group = augroup("buffer_checkpoint"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("VimResized", {
  desc = "Resize the splits if the window is resized",
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd("FileType", {
  desc = "Close some filtypes simply by pressing 'q'",
  group = augroup("close_with_q"),
  pattern = { "checkhealth", "help", "lspinfo", "man", "notify", "qf", "query" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd({ "CursorMoved", "CursorMovedI" }, {
  desc = "Redraw the cursorline when navigating around the buffer",
  group = augroup("cursorline_number"),
  callback = function()
    if vim.wo.cursorline then
      vim.cmd("redraw")
    end
  end,
})

autocmd("BufNewFile", {
  desc = "Create an EditorConfig file",
  group = augroup("editorconfig_template"),
  pattern = "**/.editorconfig",
  command = "0r ~/.config/nvim/skeletons/editorconfig.txt",
})

autocmd("BufNewFile", {
  desc = "Create a simple README.md file",
  group = augroup("readme_template"),
  pattern = "**/README.md",
  command = "0r ~/.config/nvim/skeletons/readme.md",
})

autocmd("BufNewFile", {
  desc = "Create a Dependabot configuration file",
  group = augroup("dependabot_template"),
  pattern = "**/.github/dependabot.yml",
  command = "0r ~/.config/nvim/skeletons/dependabot.yml",
})

autocmd("BufNewFile", {
  desc = "Create a GitHub Workflow file",
  group = augroup("github_workflow_template"),
  pattern = "**/.github/workflows/*.yml",
  command = "0r ~/.config/nvim/skeletons/github-workflow.yml",
})

autocmd("BufNewFile", {
  desc = "Create a template Taskfile.yml",
  group = augroup("taskfile_template"),
  pattern = "**/Taskfile.yml",
  command = "0r ~/.config/nvim/skeletons/taskfile.yml",
})

autocmd("BufNewFile", {
  desc = "Create an entrypoint file for Python projects",
  group = augroup("python_entrypoint_file"),
  pattern = "**/main.py",
  command = "0r ~/.config/nvim/skeletons/main.py",
})

autocmd("BufNewFile", {
  desc = "Create a LICENSE Plain-Text file for projects on GitHub",
  group = augroup("license_template"),
  pattern = "**/LICENSE",
  command = "0r ~/.config/nvim/skeletons/license.txt",
})
