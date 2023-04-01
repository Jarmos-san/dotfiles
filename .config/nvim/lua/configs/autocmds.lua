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

-- INFO: See the documentations below for an explanation on it works:
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim#events
autocmd("User", {
  desc = "Print a helpful message when Mason is about to install the LSP servers",
  group = augroup("mason"),
  pattern = "MasonToolsStartingInstall",
  callback = function()
    vim.schedule(function()
      print("Mason is starting...")
    end)
  end,
})

autocmd("User", {
  desc = "Print a helpful message when Mason is done updating the LSP servers",
  group = augroup("mason"),
  pattern = "MasonToolsUpdateCompleted",
  callback = function()
    vim.schedule(function()
      print("Mason completed updating LSP servers...")
    end)
  end,
})

autocmd("User", {
  desc = "Open Alpha dashboard when all buffers are removed",
  group = augroup("open_alpha_on_buffer_removal"),
  pattern = "BDeletePost*",
  callback = function(event)
    local fallback_name = vim.api.nvim_buf_get_name(event.buf)
    local fallback_filetype = vim.api.nvim_buf_get_option(event.buf, "filetype")
    local fallback_on_empty = fallback_name == "" and fallback_filetype == ""

    if fallback_on_empty then
      vim.cmd("Neotree close")
      vim.cmd("Alpha")
      vim.cmd(event.buf .. "bwipeout")
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
  pattern = { "qf", "help", "man", "notify", "lspinfo", "tsplayground", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
