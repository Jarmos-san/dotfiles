-- Module for configuring Golang filetypes

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local format = require("utils").format
local map = require("utils").map

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_buffer"),
  callback = function()
    -- INFO: The command to format the contents of the buffer
    local gofmt_command = "silent %!gofmt %"

    -- INFO: Invoke the formatting command with special logic
    format(gofmt_command)
  end,
})

map("n", "<F5>", "<CMD>terminal go run %<CR>")
