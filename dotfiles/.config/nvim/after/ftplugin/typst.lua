-- Start the Treesitter parsing process
vim.treesitter.start()

-- Enable the "tinymist" LSP server for Typst files
vim.lsp.enable("tinymist", true)

-- Setup linebreaks and soft wraps for easier viewing of the contents in a buffer
vim.opt.wrap = true
vim.opt.linebreak = true
