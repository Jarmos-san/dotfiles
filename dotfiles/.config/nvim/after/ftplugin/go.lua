-- Module for configuring Golang filetypes

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_buffer"),
  callback = function()
    -- INFO: The command to format the contents of the buffer
    local gofmt_command = "silent %!gofmt %"

    -- INFO: Get the current location of the cursor on the current window
    local cursor = vim.api.nvim_win_get_cursor(0)

    -- INFO: The formatting command to invoke after the contents are saved
    vim.cmd(gofmt_command)

    -- INFO: In case the formatting got rid of the line we came from
    cursor[1] = math.min(cursor[1], vim.api.nvim_buf_line_count(0))

    -- INFO: Update the current cursor location according to the caluclated values
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})
