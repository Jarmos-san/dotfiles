-- Module describing the Vue-specification configurations or Neovim

-- Enable and start the Treesitter parser
vim.treesitter.start()

-- Folding configurations for Neovim
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.o.foldmethod = "expr" -- Allow folding using an expression
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use Treesitter for the folding logic
  vim.o.foldlevel = 1 -- Configure the maximum indenting for the folding
  vim.wo.foldcolumn = "auto" -- Show fold indicators on the left margin
  vim.wo.foldnestmax = 3 -- Maximum depth of folds
  vim.o.foldclose = "all" -- Close all folds when the cursor moves away from the region
end
