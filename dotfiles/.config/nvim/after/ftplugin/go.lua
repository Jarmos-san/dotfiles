-- Module for configuring Golang filetypes

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_go_files"),
  callback = function()
    require("lint").try_lint()
  end,
})

-- Setup a keymap to invoke the Go executable
if vim.fn.expand("%:t") == "main.go" then
  vim.keymap.set("n", "<F5>", "<CMD>terminal go run %<CR>")
end

-- Enable the Treesitter parsing
vim.treesitter.start()

-- Configure the indent-based folds for Go buffers
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldlevel = 0 -- Start with folds closed
  vim.wo.foldcolumn = "auto" -- Show fold indicators on the left margin
  vim.wo.foldnestmax = 99 -- Maximum depth of folds
end

-- Start the "gopls" LSP server
vim.lsp.enable("gopls", true)
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
