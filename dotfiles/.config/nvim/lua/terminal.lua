-- This module contains the Lua code to configure the inbuilt terminal

local M = {}

M.setup = {
  float = function()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer

    -- Various settings of the window
    local width = math.floor(vim.o.columns * 0.8) -- 80% of the screen size
    local height = math.floor(vim.o.lines * 0.5) -- 50% of the screen size
    local row = (vim.o.lines - height) / 2
    local col = (vim.o.columns - width) / 2
    local title = string.format("Terminal (%s)", vim.o.shell)

    -- Configure the settings of the window
    local opts = {
      relative = "editor",
      row = row,
      col = col,
      width = width,
      height = height,
      border = "rounded",
      title = title,
      title_pos = "center",
    }

    -- Create a floating window to render the terminal into
    vim.api.nvim_open_win(buf, true, opts)

    -- Open a terminal session in the floating window
    vim.fn.termopen(vim.o.shell)
  end,

  vertical = function()
    local buf = vim.api.nvim_create_buf(false, true)

    -- Create a buffer to open the terminal in
    vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
    vim.fn.termopen(vim.o.shell)
  end,
}

return M
