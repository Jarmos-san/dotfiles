-- Start the Treesitter parsing process
vim.treesitter.start()

-- Enable the "tinymist" LSP server for Typst files
vim.lsp.enable("tinymist", true)
