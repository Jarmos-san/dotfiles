-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local M = {}

function M.render()
  return table.concat({ "NORMAL", " %f", "%#StatusLine#%=", "Jarmos!" })
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M
