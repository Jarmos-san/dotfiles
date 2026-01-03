---Filetype-based statusline supression.
---
---@module 'statusline.disabled'
local M = {}

local disabled = { ministarter = true, lazy = true, mason = true }

---Check whether a buffer should suppress the statusline.
---
---@param buf integer
---@return boolean
M.is_disabled = function(buf)
  return disabled[vim.bo[buf].filetype]
end

return M
