-- Module for configuring Golang filetypes

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_buffer"),
  pattern = { "*.go" },
  callback = function()
    -- TODO: Figure a Lua native way to invoke the following command
    -- INFO: Run the shell command with the current buffer in context
    vim.cmd([[ silent %!gofmt % ]])
  end,
})
