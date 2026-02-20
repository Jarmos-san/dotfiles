---@module 'statusline.modes'
local M = {}

---Mapping of Neovim editing modes to statusline presentation metadata.
---
---This table returns the raw mode codes returned by
---`vim.api.nvim_get_mode().mode` into a human-readable label for display and
---a highlight group name applied to the segment.
---
---The mapping is static and intentionally defined at module scope to avoid
---per render allocation, centralise mode semantics and keep the render
---function free of side effects.
---
---@class StatuslineMode
---@field label string Human-readable mode name shown in the statusline.
---@field hl string Highlight group name applied to the mode segment.
---
---@type table<string, StatuslineMode>
local modes = {
  n = { label = "NORMAL", hl = "StatuslineModeNormal" },
  no = { label = "NORMAL", hl = "StatuslineModeNormal" },
  v = { label = "VISUAL", hl = "StatuslineModeVisual" },
  V = { label = "VISUAL LINE", hl = "StatuslineModeVisual" },
  [""] = { label = "VISUAL BLOCK", hl = "StatuslineModeVisual" },
  s = { label = "SELECT", hl = "StatuslineModeVisual" },
  S = { label = "SELECT LINE", hl = "StatuslineModeVisual" },
  [""] = { label = "SELECT BLOCK", hl = "StatuslineModeVisual" },
  i = { label = "INSERT", hl = "StatuslineModeInsert" },
  ic = { label = "INSERT", hl = "StatuslineModeInsert" },
  R = { label = "REPLACE", hl = "StatuslineModeReplace" },
  Rv = { label = "REPLACE (VISUAL)", hl = "StatuslineModeReplace" },
  c = { label = "COMMAND", hl = "StatuslineModeCommand" },
  cv = { label = "COMMAND (VIM EX)", hl = "StatuslineModeCommand" },
  ce = { label = "COMMAND (EX)", hl = "StatuslineModeCommand" },
  r = { label = "PROMPT", hl = "StatuslineModeCommand" },
  rm = { label = "MORE", hl = "StatuslineModeCommand" },
  ["r?"] = { label = "CONFIRM", hl = "StatuslineModeCommand" },
  ["!"] = { label = "SHELL", hl = "StatuslineModeCommand" },
  t = { label = "TERMINAL", hl = "StatuslineModeTerminal" },
  nt = { label = "TERMINAL", hl = "StatuslineModeTerminal" },
}

---Configure custom highlight groups used by the statusline.
---
---This function defines mode-specific highlight groups by delegating to
---`vim.api.nvim_set_hl`. All highlights are applied in the global namespace
---(ns_id = 0).
---
---@return nil
local setup_highlights = function()
  local hl = vim.api.nvim_set_hl
  local colors = require("colors").colors
  local bg = colors.bg.bg1

  hl(0, "StatuslineModeNormal", { fg = colors.bright.green, bg = bg, bold = true })
  hl(0, "StatuslineModeInsert", { fg = colors.bright.blue, bg = bg })
  hl(0, "StatuslineModeVisual", { fg = colors.bright.purple, bg = bg })
  hl(0, "StatuslineModeCommand", { fg = colors.bright.yellow, bg = bg })
  hl(0, "StatuslineModeReplace", { fg = colors.bright.red, bg = bg })
  hl(0, "StatuslineModeTerminal", { fg = colors.bright.aqua, bg = bg })
end

---Build and return the statusline segment representing the current editor
---mode.
---
---This function queries Neovim for the active editor mode using
---`vim.api.nvim_get_mode().mode` and resolves the corresponding presentation
---metadata froom the `MODES` table.
---
---If the current mode is not explicitly mapped in `MODES`, the function
---returns `nil` allowing callers to omit the segment entirely. This defensive
---behaviour prevents rendering stale or misleading model labels when Neovim
---introduces ne or transient mode codes.
---
---@return string | nil
---A formatted statusline segment containing the current mode label with its
---associated highlight group applied or `nil` if the mode is not supported.
---
---@see vim.api.nvim_get_mode
---@see MODES
M.render = function()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = modes[current_mode]

  if not mode_info then
    return nil
  end

  setup_highlights()

  return string.format("%%#%s# %s ", mode_info.hl, mode_info.label)
end

return M
