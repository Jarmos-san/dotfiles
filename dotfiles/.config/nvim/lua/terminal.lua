-- This module contains the Lua code to configure the inbuilt terminal

local M = {}

local buf, win

local create_term = function()
  vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      buf, win = nil, nil
    end,
  })
end

M.setup = {
  float = function()
    buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer

    -- Various settings of the window
    local width = math.floor(vim.o.columns * 0.8) -- 80% of the screen size
    local height = math.floor(vim.o.lines * 0.5) -- 50% of the screen size
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
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
    win = vim.api.nvim_open_win(buf, true, opts)

    -- Open a terminal session in the floating window
    create_term()
  end,

  vertical = function()
    buf = vim.api.nvim_create_buf(false, true)

    -- Open a vertical split and switch to it
    vim.api.nvim_open_win(buf, true, { split = "right" })

    -- Open a terminal session in the floating window
    create_term()
  end,

  toggle = function()
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
      buf, win = nil, nil
      return
    end

    buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer

    -- Various settings of the window
    local width = math.floor(vim.o.columns * 0.8) -- 80% of the screen size
    local height = math.floor(vim.o.lines * 0.5) -- 50% of the screen size
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
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
    win = vim.api.nvim_open_win(buf, true, opts)

    -- Open a terminal session in the floating window
    create_term()
  end,
}

return M
