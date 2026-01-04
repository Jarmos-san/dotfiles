---Utility helpers for statusline rendering.
---
---@module 'statusline.utils'
local M = {}

--- Append one more values to a table, ignoring `nil` values.
---
--- This helper is intended for incremental construction of ordered tables
--- (e.g., statusline segments), where optional components may return `nil`
--- to indicate "nothing to render".
---
--- Values are appended in the order provided and any `nil` values are skipped.
---
--- @generic T
--- @param t T[]          -- Target table to append values to.
--- @param ... T | nil    -- One or more values to append
--- @return nil
M.push_if_present = function(t, ...)
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if v ~= nil then
      t[#t + 1] = v
    end
  end
end

return M
