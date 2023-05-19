-- Module for configuring some global autocommand which will always be loaded at startup

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

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

-- TODO: Create an autocommand for an EditorConfig template as well!

-- TODO: Use this example Lua API autocommand for brevity & better readability
-- autocmd("BufNewFile", {
--   desc = "Create a sample template.",
--   group = augroup("sample_template"),
--   pattern = "markdown",
--   callback = function()
--     -- Read the contents of the skeleton file (or the template)
--     local readfile = vim.fn.readfile(vim.env.HOME .. "/.config/skeletons/sample.md")
--     local contents = table.concat(readfile, "\n")
--
--     -- Load the buffer to replace the contents of with the template instead.
--     local bufnr = vim.api.nvim_get_current_buf()
--
--     -- Write the contents of the template to the buffer instead.
--     vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, vim.split(contents, "\n"))
--   end,
-- })
