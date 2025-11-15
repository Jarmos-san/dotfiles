-- Folding configurations for Neovim
if vim.api.nvim_buf_line_count(0) >= 100 then
  vim.o.foldmethod = "expr" -- Allow folding using the "nvim-treesitter" plugin
  vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Configure the folding algorithm to be from the plugin
  vim.o.foldlevel = 0 -- Configure the maximum indenting for the folding
end

vim.treesitter.start()

-- TODO: Move this autocommand to its own module/package
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = vim.api.nvim_get_current_buf(),
  callback = function()
    local hover_window_configs = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }

    vim.diagnostic.open_float(nil, hover_window_configs)
  end,
})
