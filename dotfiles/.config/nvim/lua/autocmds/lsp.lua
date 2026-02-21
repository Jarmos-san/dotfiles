-- This module defines an autocommand that automatically displays a floating
-- diagnostic window when the cursor remains idle (`CursorHold`).
vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Open/Close hover window for LSP",
  group = vim.api.nvim_create_augroup("LspHoverWindow", { clear = true }),
  callback = function()
    local config = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }

    vim.diagnostic.open_float(nil, config)
  end,
})
