-- Folding configurations for Neovim
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.o.foldmethod = "expr" -- Allow folding using the "nvim-treesitter" plugin
  vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Configure the folding algorithm to be from the plugin
  vim.o.foldlevel = 0 -- Configure the maximum indenting for the folding
end

vim.treesitter.start()
