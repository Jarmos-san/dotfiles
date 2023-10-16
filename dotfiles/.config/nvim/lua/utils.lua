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

return M
