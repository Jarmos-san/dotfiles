local M = {}

-- Utlity function to make autocommands easily
M.autocmd = vim.api.nvim_create_autocmd

-- Utlity function to make augroups more easily
M.augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- Utlity function to make keybind mappings easier & DRY
M.map = function(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys

  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.format = function(command)
  -- INFO: Get the current location of the cursor on the current window
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- INFO: The formatting command to invoke after the contents are saved
  vim.cmd(command)

  -- INFO: In case the formatting got rid of the line we came from
  cursor[1] = math.min(cursor[1], vim.api.nvim_buf_line_count(0))

  -- INFO: Update the current cursor location according to the caluclated values
  vim.api.nvim_win_set_cursor(0, cursor)
end

return M
