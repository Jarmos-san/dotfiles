---Statusline highlight group definitions and setup logic.
---
---This module defines all highlight groups required by the statusline and
---applies them using `vim.api.nvim_set_hl`. It is intended to be executed
---during initialization (e.g., startup or colorscheme reload).
---
---@module 'statusline.highlights'
local M = {}

local hl = vim.api.nvim_set_hl
local colors = require("statusline.colors").COLORS

---Declaractive registry of all the highlight groups.
---
---This table defines the complete list of all the highlight groups used by
---the statusline and their corresponding foreground/background colours. The
---keys represent Neovim highlight group names and they passed directly to the
---`nvim_set_hl(0, group, spec)` function.
---
---@alias StatuslineHighlight vim.api.keyset.highlight
---@type table<string, StatuslineHighlight>
local HIGHLIGHTS = {
  StatuslineModeNormal = { fg = colors.bright.green, bg = colors.bg.bg1, bold = true },
  StatuslineModeInsert = { fg = colors.bright.blue, bg = colors.bg.bg1 },
  StatuslineModeVisual = { fg = colors.bright.purple, bg = colors.bg.bg1 },
  StatuslineModeCommand = { fg = colors.bright.yellow, bg = colors.bg.bg1 },
  StatuslineModeReplace = { fg = colors.bright.red, bg = colors.bg.bg1 },
  StatuslineModeTerminal = { fg = colors.bright.aqua, bg = colors.bg.bg1 },
  StatuslineFilePath = { fg = colors.bright.gray, bg = colors.bg.bg0_h },
  StatuslineCursor = { fg = colors.bg.bg0_h, bg = colors.fg.fg0 },
  StatuslineCursorGlyph = { fg = colors.bg.bg0_h, bg = colors.bright.orange },
  StatuslineGitBranch = { fg = colors.bg.bg0_h, bg = colors.fg.fg0 },
}

---Apply all statusline highlight groups.
---
---Iterates over the declarative `HIGHLIGHTS` group and applies each highlight
---specification using the `vim.api.nvim_set_hl()` function. The function is
---intended to be used once during the setup process.
---
---The function should not be called during render paths to avoid unnecessary
---work and side effects during the statusline evaluation.
---
---@return nil
M.setup = function()
  for name, spec in pairs(HIGHLIGHTS) do
    hl(0, name, spec)
  end
end

return M
