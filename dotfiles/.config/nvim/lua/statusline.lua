---@module This module contains the logic to render a custom statusline.

---A wrapper over the Lua function to set the highlight groups and the
---associated colours for the group.
---
---@see vim.api.nvim_set_hl to learn more.
local hl = vim.api.nvim_set_hl

---Statusline module's public interface.
---
---This interface exposes minimal and explicit API for managing a custom Neovim
---statusline by providing the following methods:
---   - `setup()` performs a one-time configuration and initialization.
---   - `render()` returns the dynamically rendered statusline.
---
---Consumers of the module should only rely on the documented fields below.
---
---@class Statusline
---@field render fun(): string
---@field setup fun(): nil
local M = {}

---@class ColorBase
---@field bg string
---@field fg string

---@class ColorSet
---@field red string
---@field green string
---@field yellow string
---@field blue string
---@field purple string
---@field aqua string
---@field gray string
---@field orange string

---@class BackgroundSet
---@field bg0_h string
---@field bg0 string
---@field bg1 string
---@field bg2 string
---@field bg3 string
---@field bg4 string

---@class ForegroundSet
---@field fg0 string
---@field fg1 string
---@field fg2 string
---@field fg3 string
---@field fg4 string

---@class Colors
---@field base ColorBase
---@field normal ColorSet
---@field bright ColorSet
---@field bg BackgroundSet
---@field fg ForegroundSet
local colors = {
  base = {
    bg = "#282828",
    fg = "#ebdbb2",
  },

  normal = {
    red = "#cc241d",
    green = "#98971a",
    yellow = "#d79921",
    blue = "#458588",
    purple = "#b16286",
    aqua = "#689d6a",
    gray = "#a89984",
    orange = "#d65d0e",
  },

  bright = {
    red = "#fb4934",
    green = "#b8bb26",
    yellow = "#fabd2f",
    blue = "#83a598",
    purple = "#d3869b",
    aqua = "#8ec07c",
    gray = "#928374",
    orange = "#fe8019",
  },

  bg = {
    bg0_h = "#1d2021",
    bg0 = "#282828",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    bg4 = "#7c6f64",
  },

  fg = {
    fg0 = "#fbf1c7",
    fg1 = "#ebdbb2",
    fg2 = "#d5c4a1",
    fg3 = "#bdae93",
    fg4 = "#a89984",
  },
}

---@alias ModeLabel string
---@alias HighlightGroup string

---@class StatuslineMode
---@field label ModeLabel
---@field hl HighlightGroup

---Builds and returns the statusline segment representing the current Neovim
---mode.
---
---This function queries Neovim for the active editor mode, resolves the
---corresponding label and highlight group from the `modes` table and formats
---the result using statusline highlight syntax.
---
---If the current mode is not explicitly defined in the `modes` table, a safe
---fallback (`UNKNOWN` with normal-mode highlight) is used.
---
---@return string
---A formatted statusline segment containing the mode label with the
---appropriate highlight group applied. The `string.format()` function first
---escapes Lua's  formatting rules so that `%%` becomes a literal `%`, allowing
---Neovim's statusline syntax to be emitted safely. The resulting string
---switches to the specified highlight group (`%#..#`) and renders the mode
---label using that highlight.
---
---@see vim.api.nvim_get_mode
local get_mode = function()
  ---The table representing a mapping of colours to be assigned to a specific
  ---highlight group.
  local groups = {
    StatuslineModeNormal = colors.bright.green,
    StatuslineModeInsert = colors.bright.blue,
    StatuslineModeVisual = colors.bright.purple,
    StatuslineModeCommand = colors.bright.yellow,
    StatuslineModeReplace = colors.bright.red,
    StatuslineModeTerminal = colors.bright.aqua,
  }

  ---@type table<string, StatuslineMode>
  ---The various Vim modes and their respective codes as returned by the mode() function.
  ---
  ---@see vim.api.nvim_get_mode for more information.
  local modes = {
    ["n"] = { label = "NORMAL", hl = "StatuslineModeNormal" },
    ["no"] = { label = "NORMAL", hl = "StatuslineModeNormal" },
    ["v"] = { label = "VISUAL", hl = "StatuslineModeVisual" },
    ["V"] = { label = "VISUAL LINE", hl = "StatuslineModeVisual" },
    [""] = { label = "VISUAL BLOCK", hl = "StatuslineModeVisual" },
    ["s"] = { label = "SELECT", hl = "StatuslineModeVisual" },
    ["S"] = { label = "SELECT LINE", hl = "StatuslineModeVisual" },
    [""] = { label = "SELECT BLOCK", hl = "StatuslineModeVisual" },
    ["i"] = { label = "INSERT", hl = "StatuslineModeInsert" },
    ["ic"] = { label = "INSERT", hl = "StatuslineModeInsert" },
    ["R"] = { label = "REPLACE", hl = "StatuslineModeReplace" },
    ["Rv"] = { label = "REPLACE (VISUAL)", hl = "StatuslineModeReplace" },
    ["c"] = { label = "COMMAND", hl = "StatuslineModeCommand" },
    ["cv"] = { label = "COMMAND (VIM EX)", hl = "StatuslineModeCommand" },
    ["ce"] = { label = "COMMAND (EX)", hl = "StatuslineModeCommand" },
    ["r"] = { label = "PROMPT", hl = "StatuslineModeCommand" },
    ["rm"] = { label = "MOAR", hl = "StatuslineModeCommand" },
    ["r?"] = { label = "CONFIRM", hl = "StatuslineModeCommand" },
    ["!"] = { label = "SHELL", hl = "StatuslineModeCommand" },
    ["t"] = { label = "TERMINAL", hl = "StatuslineModeTerminal" },
    ["nt"] = { label = "TERMINAL", hl = "StatuslineModeTerminal" },
  }

  -- Get the current mode and its name
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = modes[current_mode] or { label = "UNKNOWN", hl = "StatuslineModeNormal" }

  -- Set the background colour for the segment
  local bg = colors.bg.bg1

  -- Apply the highlight groups
  for name, color in pairs(groups) do
    hl(0, name, { fg = color, bg = bg })
  end

  -- Example rendered string - `"%#StatuslineModeInsert# INSERT"`
  return string.format("%%#%s# %s ", mode_info.hl, mode_info.label)
end

---Builds and returns the statusline segment representing LSP diagnostic counts.
---
---This function aggregates diagnostics for the current buffer, grouped by
---severity (errors, warnings, hints and informational messages). Each non-zero
---diagnostic category is rendered as a statusline segment with its
---corresponding highlight group and count.
---
---If no diagnostics are present for a given severity that segment is omitted.
---The returned string always resets the highlight group back to `Normal`.
---
---@return string
---A formatted statusline segment containing zero or more diagnostic
---indicators.
---
---@see vim.diagnostic
local get_diagnostics = function()
  ---Aggregated diagnostic couunts by category.
  ---@class DiagnosticCount
  ---@field errors integer
  ---@field warnings integer
  ---@field info integer
  ---@field hints integer

  ---@type DiagnosticCount
  local count = {
    errors = 0,
    warnings = 0,
    info = 0,
    hints = 0,
  }

  ---Mapping of diagnostic categories to Neovim severity levels
  ---@type table<DiagnosticCount, vim.diagnostic.Severity>
  local levels = {
    errors = vim.diagnostic.severity.ERROR,
    warnings = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hints = vim.diagnostic.severity.HINT,
  }

  -- Count diagnostics per severity for the current buffer
  for key, level in pairs(levels) do
    count[key] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  -- Rendered statusline segments for each diagnostic category
  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "%#LspDiagnosticsSignError#  " .. count["errors"]
  end

  if count["warnings"] ~= 0 then
    warnings = "%#LspDiagnosticsSignWarning#  " .. count["warnings"]
  end

  if count["hints"] ~= 0 then
    hints = "%#LspDiagnosticsSignHint# 󰮥 " .. count["hints"]
  end

  if count["info"] ~= 0 then
    info = "%#LspDiagnosticsSignInformation#  " .. count["info"]
  end

  -- Concatenate all active segments and reset highlights to `Normal`
  return errors .. warnings .. hints .. info
end

---Builds and returns the statusline segment representing the current file
---path.
---
---The filepath is resolved relative to the current working directory and `~`
---is used to represent the home directory and `.` is used for paths relative
---to the current working directory.
---
---If the current buffer has no associated file (e.g., `[No Name]`) or resolves
---to `"."`, a single space is returned to preserve statusline spacing.
---
---@return string
---A formatted statusline segment containing the current file path or a single
---space if no valid path is available.
local get_filepath = function()
  -- Resolved and normalized file path for the current buffer.
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

  if fpath == "" or fpath == "." then
    return " "
  end

  -- Set the "modifiable" icon to signify an editable buffer
  local modifiable
  if vim.bo.modifiable then
    modifiable = "[+]"
  else
    modifiable = "[-]"
  end

  hl(0, "StatuslineFilePath", { fg = colors.bright.gray, bg = colors.bg.bg0_h })

  return string.format("%%#StatuslineFilePath# %s %s", modifiable, fpath)
end

---Builds and returns the statusline segment representing the cursor position
---with a visual progress indicator.
---
---The cursor position is expressed as `line:column`, where `line` is the
---current 1-based line number and `column` is the current 1-based column
---number. The numbers are followed by a Nerd Font glyph to showcase the
---progress through the current buffer.
---
---The progress is calculated as a normalized ratio of the current line number
---to the total number of lines in the buffer and mapped to one of several
---increasingly filled block glyphs (low -> high). This provides a compact and
---single-cell progress indicator which avoids statusline jitter while
---remaining visually expressive.
---
---This mirrors common editor conventions and provides a compact, readable
---cursor indicator suitable for use in a statusline.
---
---@return string
---A formatted statusline segment containing the current cursor location.
local get_cursor_location = function()
  -- Current cursor position
  local line = vim.fn.line(".")
  local column = vim.fn.col(".")

  -- Total number of lines in the buffer
  local total_lines = vim.fn.line("$")

  -- Normalised progress (0.0 -> 1.0)
  local progress = line / math.max(total_lines, 1)

  -- Nerd Font progress blocks (low -> high)
  local blocks = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }

  -- Map progress to a block index
  local index = math.max(1, math.ceil(progress * #blocks))
  local glyph = blocks[index]

  ---The table representing the mappings of the highlight groups and their
  ---associated colours
  local group = {
    StatuslineCursorPos = colors.bright.aqua,
    StatuslineCursorGlyph = colors.normal.orange,
  }

  -- The background colour
  local bg = colors.bg.bg0_h

  -- Apply the highlight groups and their associated colours
  for name, color in pairs(group) do
    hl(0, name, { fg = color, bg = bg })
  end

  return string.format("%%#StatuslineCursorPos#%s:%s %%#StatuslineCursorGlyph#%s ", line, column, glyph)
end

---Renders and returns the complete statusline string.
---
---This function composes the final statusline by concatenating individual
---segments produced by the module's helper functions. The `%=` item is used to
---seperate left-aligned and right-aligned sections following Neovim's
---statusline formatting rules. It ignores the rendering logic if the buffer's
---filetype is identified to be "ministarter".
---
---@return string
---The fully formatted statusline string ready to be assigned to the
---`statusline` option.
---
---@see vim.o.statusline
function M.render()
  -- Mapping of filetypes where the statusline should be disabled
  local disabled_filestypes = { ministarter = true, lazy = true, mason = true }

  -- Get the filetype of the current active buffer
  local buf = vim.api.nvim_win_get_buf(0)
  local ft = vim.bo[buf].filetype

  -- Apply the "Normal" highlight group to the statusline to represent a
  -- "disabled" filetype
  if disabled_filestypes[ft] then
    return "%#Normal#"
  end

  -- Build the statusline (if it wasn't disabled) by concatenating all the
  -- segments in to one single table
  return table.concat({
    get_mode(),
    get_diagnostics(),
    get_filepath(),
    "%=",
    get_cursor_location(),
  })
end

---Initialise the statusline.
---
---This function performs all one-time setup required for the custom
---statusline. It registers the highlight groups used by the statusline and
---configures the global `statusline` option to delegate rendering to Lua.
---
---It is expected to be called during Neovim startup and it is safe to be
---executed repeatedly for example after a `ColorScheme` change.
---
---@return nil
function M.setup()
  vim.o.statusline = "%!v:lua.require('statusline').render()"
end

return M
