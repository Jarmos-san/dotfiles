local M = {}

M.load = function()
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end

  vim.g.colors_name = "tansai"
  vim.o.termguicolors = true
  vim.o.background = "dark"

  vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none", fg = "none" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", fg = "none" })
end

return M
