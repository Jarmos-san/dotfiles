-- A minimal, window-aware winbar implementation.
--
-- This module installs a global `winbar` expression which delegates rendering
-- to a Lua function via Neovim's `%!` statusline evaluation mechanism.

---@class Winbar
---@field render fun(): string -- Returns the evaluated winbar setting
---@field setup fun(): nil -- Installs the winbar expression globally
local M = {}

local hl = vim.api.nvim_set_hl
local colors = require("colors").colors
local fg = colors.fg.fg4

-- Set the base highlight group for the winbar
hl(0, "Winbar", { fg = fg, bg = "#1c1c1c" })
hl(0, "WinbarFlag", { fg = fg })

---Filetypes for which the winbar should be suppressed. Using a set-style
---table allows O(1) membership checks.
---@type table<string, boolean>
local disabled_filetypes = {
  ministarter = true,
  gitrebase = true,
  gitcommit = true,
}

---Render function evaluated by Neovim's winbar engine.
---
---This function is executed every time the winbar is redrawn because it is
---invoked via the `%!` expression mechanism:
---
---   vim.o.winbar = '%!v:lua.require("winbar").render()'
---
---The winbar expression MUST return a string, otherwise returning `nil` will
---render as `v:null`. Returning an empty string (`""`) cleanly suppresses the
---output.
---
---@return string
M.render = function()
  local icons = require("winbar.icons")
  local filepath = require("winbar.filepath")

  -- Get the filetype of the current active buffer
  local winid = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(winid)
  local ft = vim.bo[buf].filetype

  -- Suppress the winbar for certain filetypes
  if disabled_filetypes[ft] then
    return ""
  end

  -- Render the icons and the filepaths for the segment
  local icon = icons.get_filetype_icon(buf)
  local paths = filepath.render(buf)

  -- Render the complete winbar
  return string.format(" %%#WinbarFlag#%%r %s %s %%#WinbarFlag#%%m%%*", icon, paths)
end

---Initialises the global winbar option.
---
---This assigns a Vim expression (`%!`) which evaluates the Lua function on
---every redraw. The option is set globally (using `vim.opt`) so all windows
---inherit it automatically.
---
---NOTE: It should be called once during startup.
---
---@return nil
M.setup = function()
  vim.opt.winbar = '%!v:lua.require("winbar").render()'
end

return M
