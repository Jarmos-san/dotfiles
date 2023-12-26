-- Module for configuring Golang filetypes

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local map = require("utils").map

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_go_files"),
  callback = function()
    require("lint").try_lint()
  end,
})

map("n", "<F5>", "<CMD>terminal go run %<CR>")
