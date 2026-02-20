---Utility module for resolving and rendering filetype icons using `nvim-web-devicons`.
---
---This module exposes helper function to extract the filename and extension from a
---buffer, resolve the appropriate devicon via `nvim-web-devicons` and render the icon
---wrapped in its highlight group using a statusline-compatible highlight syntax.
---
---@module "winbar.icon"
local M = {}

---Resolves the devicon and its highlight group for a buffer.
---
---The function fetches the icon for a specific filetype of a buffer from the
---`nvim-web-devicons` plugin. If the buffer has no name, resolution is skipped.
---
---@param buf integer Buffer handle (use `0` for current buffer).
---@return string|nil icon Resolved icon (nil if unavailable).
---@return string|nil hl_group Highlight group for the icon (nil if unavailable).
local get_filetype_icon = function(buf)
  local devicons = require("nvim-web-devicons")

  local filename = vim.api.nvim_buf_get_name(buf)
  local extension = vim.fn.fnamemodify(filename, ":e")

  ---@type string|nil icon
  ---@type string|nil hl_group
  local icon, hl_group = devicons.get_icon(filename, extension, { default = true })

  return icon, hl_group
end

---Render the formatted icon string for the winbar usage.
---
---If an icon is resolved, it is wrapped using `%#HighlightGroup#icon%*`. If no icon
---exists, an empty string is returned.
---
---@param buf integer The buffer handle (use `0` for the current buffer).
---@return string|nil
M.render = function(buf)
  local icon, hl = get_filetype_icon(buf)

  if icon then
    return string.format("%%#%s#%s%%*", hl, icon)
  end

  return nil
end

return M
