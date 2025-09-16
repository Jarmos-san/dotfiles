-- Custom highlights to override the highlights set by whatever colorscheme is used
-- at any given moment

local M = {}

M.setup = function()
  -- Apply a black border around the completion menu
  vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#000000" })

  -- Apply whitish foreground to the selected item in the completion menu and a darker
  -- background to the background for better visibility
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = "#dce0dc", bg = "#434543", bold = true })
end

return M
