-- This module contains the Lua code to configure the inbuilt terminal

local M = {}

local create_term = function(width, height, row, col, opts)
  local buf = vim.api.nvim_create_buf(false, true)

  -- Conditionally apply terminal aesthetics depending on its type - either floating or vertical split
  if not opts then
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = opts.style,
      border = opts.border,
    })
  else
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
    })
  end

  -- Start the terminal shell using the value of "$SHELL"
  vim.fn.termopen(vim.o.shell)
end

M.setup = {
  float = function()
    local width = math.floor(vim.o.columns * 0.8) -- 80% of editor width
    local height = math.floor(vim.o.lines * 0.5) -- 50% of editor height
    local row = (vim.o.lines - height) / 2 -- Center vertically
    local col = (vim.o.columns - width) / 2 -- Center horizontally

    -- Create the terminal inside the floating window
    create_term(width, height, row, col, { style = "minimal", border = "rounded" })
  end,

  vertical = function()
    -- local width = math.floor(vim.o.columns * 0.5) -- Set the width for the new split (50% of the current width)
    -- local height = vim.api.nvim_win_get_height(0) -- Use the current window's height
    -- local row = 0 -- Start from the top of the window
    -- local col = vim.api.nvim_win_get_width(0) -- Place it at the right side of the current window

    -- Create the terminal inside the vertical split
    -- create_term(width, height, row, col, {})
    -- TODO: Refactor the function
    local buf = vim.api.nvim_create_buf(false, true)

    -- Create a buffer to open the terminal in
    vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
    vim.fn.termopen(vim.o.shell)
  end,
}

return M
