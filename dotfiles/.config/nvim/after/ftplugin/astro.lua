-- Start the Treesitter parsing process
vim.treesitter.start()

-- Start the "astro" LSP server
vim.lsp.enable("astro", true)
