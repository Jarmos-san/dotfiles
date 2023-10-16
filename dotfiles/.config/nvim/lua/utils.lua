local M = {}

M.autocmd = vim.api.nvim_create_autocmd

M.augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

return M
