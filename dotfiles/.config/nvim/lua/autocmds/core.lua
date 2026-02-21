-- This module defines the collection of editor-level autocommands that enhance
-- usability, ergonomics and visual feedback within Neovim. The behaviours
-- implemented here are intentionally lightweight, synchronous and globally
-- scoped. Each autocommand is isolated in its own autogroup to ensure
-- idempotent reloading and predictable behaviour during configuration
-- refreshes.

-- Autocommand to keep the highlight of the yanked text for a few seconds for
-- better visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight the yanked text for a specified time.",
  group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 }) -- Keep the highlight for 250ms after yanking.
  end,
})

-- Jump to the last known position on a buffer before it was closed
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Jump to the last known position of a file before closing it",
  group = vim.api.nvim_create_augroup("buffer_checkpoint", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Resize the windows after the splits were closed
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize the splits if the window is resized",
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Make it easier/quicker to close certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close some filtypes simply by pressing 'q'",
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = { "checkhealth", "help", "lspinfo", "man", "notify", "qf", "query" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Trim the whitespace from the buffer contents
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim training whitespace after writing the contents of a buffer",
  group = vim.api.nvim_create_augroup("trim_trailing_whitespace", { clear = true }),
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Autocommand to apply the highlights while performing a search and replace action
vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc = "Apply highlights during search and replace",
  group = vim.api.nvim_create_augroup("apply_highlights", { clear = true }),
  pattern = { "/", "?" },
  callback = function()
    vim.o.hlsearch = true
  end,
})

-- Show the buffer write message using an ephemeral notification floating window
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = 'show ":w" message through vim.notify()',
  group = vim.api.nvim_create_augroup("WriteNotification", { clear = true }),
  callback = function(args)
    local buf = args.buf

    -- Get the name of the buffer. Exit early if the buffer is not named (or is
    -- set to "No Name")
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
      return
    end

    -- Attempt to read the statistics of the buffer (or file to write to) or
    -- throw an error if it is a failure
    ---@diagnostic disable-next-line: undefined-field
    local stat = vim.uv.fs_stat(name)
    if not stat then
      vim.notify("Failed to retrieve file metadata", vim.log.levels.ERROR, { title = "Neovim" })
      return
    end

    -- Store the filename, it's filesize and file size metrics for later usage
    local filename = vim.fn.fnamemodify(name, ":~:.")
    local size = stat and stat.size or 0
    local kb = 1024

    -- Create variables of the file sizes so that they can be represented as a
    -- notification
    local size_repr = nil
    if size < kb then
      size_repr = string.format("%dB", size)
    else
      size_repr = string.format("%.2fKB", size / kb)
    end

    -- Create a message using the evaluated metrics above
    local msg = string.format('"%s" written (%s) successfully', filename, size_repr)

    -- Generate the notification if writing the buffer contents to a file was
    -- successful
    vim.notify(msg, vim.log.levels.INFO, { title = "Neovim" })
  end,
})
