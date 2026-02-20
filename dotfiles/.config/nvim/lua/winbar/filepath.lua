---Utility module for resolving buffer filepaths.
---
---This module exposes helper functions that retrieve this absolute filesystem path
---associated with a given Neovim buffer handle. If the buffer has no associated name
---(e.g., `[No Name]`), an empty string is returned.
---
---@module "winbar.filepath"
local M = {}

-- Set up the highlights and colours for the winbar segments
local colors = require("colors").colors
local hl_group = "WinbarFilepath"
vim.api.nvim_set_hl(0, hl_group, { fg = colors.fg.fg0, bold = true })

---Returns the absolute filepath for a given buffer.
---
---Internally, the function uses `vim.api.nvim_buf_get_name(buf)` to return an absolute
---path if the buffer is associated with a file else return an empty string if the buffer
---is unnamed.
---
---@param buf integer The buffer handle (use `0` for current buffer).
---@return string[] filepaths Absolute filepaths or an empty string.
local get_filepath = function(buf)
  local bufname = vim.api.nvim_buf_get_name(buf)
  local filepath = vim.fn.fnamemodify(bufname, ":~")

  return vim.split(filepath, "/")
end

---Render the formatted winbar string.
---
---Only the filepath segments are highlighted in a whitish foreground while the
---seperator remains unstyled.
---
---@param buf integer
---@return string
M.render = function(buf)
  local segments = get_filepath(buf)

  for i, segment in ipairs(segments) do
    segments[i] = string.format("%%#%s#%s%%*", hl_group, segment)
  end

  return table.concat(segments, " 󰶻 ")
end

return M
