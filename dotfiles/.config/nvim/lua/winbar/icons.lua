---Utility module for resolving and rendering filetype icons using `nvim-web-devicons`.
---
---This module exposes helper function to extract the filename and extension from a
---buffer, resolve the appropriate devicon via `nvim-web-devicons` and render the icon
---wrapped in its highlight group using a statusline-compatible highlight syntax.
---
---@module "winbar.icon"
local M = {}

---Returns the formatted devicon string for a given buffer.
---
---The function retrieves the absolute filename from the buffer handle, extracts the
---file extension and resolves the icon/highlight group using the `nvim-web-devicons`
---plugin. Thereafter the function wraps the icon in a syntax highlight group according
---to the rendering schematics followed by Neovim. If no icon is found, an empty string
---is returned.
---
---@param buf integer Buffer handle (use `0` for current buffer).
---@return string Formatted icon string (maybe empty)
M.get_filetype_icon = function(buf)
  local devicons = require("nvim-web-devicons")

  -- Get the filetype's extension to map the devicon icon to
  local filename = vim.api.nvim_buf_get_name(buf)
  local extension = vim.fn.fnamemodify(filename, ":e")
  --
  -- Get the devicon based on the derived filetype extension
  local icon, icon_hl = devicons.get_icon(filename, extension, { default = true })

  -- Render the devicon along with its respective highlight group
  local icon_part = ""
  if icon then
    icon_part = string.format("%%#%s#%s%%*", icon_hl, icon)
  end

  return icon_part
end

return M
