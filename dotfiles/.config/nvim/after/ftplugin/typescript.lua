-- Start the Treesitter parsing process for TypeScript files
vim.treesitter.start()

-- Folding configurations for Neovim
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.o.foldmethod = "expr" -- Allow folding using the "nvim-treesitter" plugin
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Configure the folding algorithm to be from the plugin
  vim.o.foldlevel = 1 -- Configure the maximum indenting for the folding
  vim.o.foldcolumn = "auto"
  vim.o.foldnestmax = 99
end
