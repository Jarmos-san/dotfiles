-- Folding configurations for Neovim
vim.o.foldmethod = "expr" -- Allow folding using the "nvim-treesitter" plugin
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Configure the folding algorithm to be from the plugin
vim.o.foldlevel = 2 -- Configure the maximum indenting for the folding
