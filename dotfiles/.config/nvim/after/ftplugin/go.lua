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

-- Configure the indent-based folds for Go buffers
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 0 -- Start with folds closed
  vim.opt.foldcolumn = "auto" -- Show fold indicators on the left margin
  vim.opt.foldnestmax = 99 -- Maximum depth of folds
end
