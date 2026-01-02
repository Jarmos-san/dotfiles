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

---@module 'statusline'
---This module contains the logic to render a custom statusline.
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
local COLORS = {
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

---@alias StatuslineHighlight vim.api.keyset.highlight

---Declaractive registry of all the highlight groups.
---
---This table defines the complete list of all the highlight groups used by
---the statusline and their corresponding foreground/background colours. The
---keys represent Neovim highlight group names and they passed directly to the
---`nvim_set_hl(0, group, spec)` function.
---
---@type table<string, StatuslineHighlight>
local HIGHLIGHTS = {
  StatuslineModeNormal = { fg = COLORS.bright.green, bg = COLORS.bg.bg1 },
  StatuslineModeInsert = { fg = COLORS.bright.blue, bg = COLORS.bg.bg1 },
  StatuslineModeVisual = { fg = COLORS.bright.purple, bg = COLORS.bg.bg1 },
  StatuslineModeCommand = { fg = COLORS.bright.yellow, bg = COLORS.bg.bg1 },
  StatuslineModeReplace = { fg = COLORS.bright.red, bg = COLORS.bg.bg1 },
  StatuslineModeTerminal = { fg = COLORS.bright.aqua, bg = COLORS.bg.bg1 },
  StatuslineFilePath = { fg = COLORS.bright.gray, bg = COLORS.bg.bg0_h },
  StatuslineCursorGlyph = { fg = COLORS.bright.orange, bg = COLORS.bg.bg0_h },
  StatuslineGitBranch = { fg = COLORS.bright.aqua, bg = COLORS.bg.bg2 },
}

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
---@alias StatuslineMode
---@field label string Human-readable mode name shown in the statusline.
---@field hl string Highlight group name applied to the mode segment.
---
---@type table<string, StatuslineMode>
local MODES = {
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
local setup_highlights = function()
  for name, spec in pairs(HIGHLIGHTS) do
    hl(0, name, spec)
  end
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
local get_mode = function()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = MODES[current_mode]

  if not mode_info then
    return nil
  end

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
---@return string | nil
---A formatted statusline segment containing zero or more diagnostic
---indicators.
---
---@see vim.diagnostic
local get_diagnostics = function()
  ---Aggregated diagnostic counts by category.
  ---@class DiagnosticCount
  ---@field errors integer
  ---@field warnings integer
  ---@field info integer
  ---@field hints integer

  -- Count diagnostics per severity for the current buffer
  local diags = vim.diagnostic.get(0)
  if #diags == 0 then
    return nil
  end

  -- Table containing a map of the LSP diagnostics and their count
  local count = { errors = 0, warnings = 0, info = 0, hints = 0 }

  -- Iterate through the list of diagnostics and count the items
  for _, item in pairs(diags) do
    if item.severity == vim.diagnostic.severity.ERROR then
      count.errors = count.errors + 1
    end

    if item.severity == vim.diagnostic.severity.WARNING then
      count.warnings = count.warnings + 1
    end

    if item.severity == vim.diagnostic.severity.INFO then
      count.info = count.info + 1
    end

    if item.severity == vim.diagnostic.severity.HINT then
      count.hints = count.hints + 1
    end
  end

  -- The sub-segments of the parent segment
  local segments = {}

  if count.errors > 0 then
    segments[#segments + 1] = "%#LspDiagnosticsSignError# ε " .. count.errors
  end

  if count.warnings > 0 then
    segments[#segments + 1] = "%#LspDiagnosticsSignWarning#  " .. count.warnings
  end

  if count.hints > 0 then
    segments[#segments + 1] = "%#LspDiagnosticsSignHint#  " .. count.hints
  end

  if count.info > 0 then
    segments[#segments + 1] = "%#LspDiagnosticsSignInformation#  " .. count.info
  end

  return table.concat(segments)
end

---Returns a visual indicator representing the cursor's vertical position
---within the current buffer.
---
---The function computes the cursor's progress as a normalized ratio (current
---line / total lines) and maps it to a glyph chosen from a predefined sequence
---of Nerd Font block characters. The resulting glyph provides a compact,
---intuitive progress indicator suitable for use in a statusline.
---
---@return string | nil
---A formatted statusline segment containing the current cursor location.
local get_cursor_glyph = function()
  -- Total number of lines in the buffer
  local total_lines = vim.fn.line("$")

  -- No meaningful cursor context
  if total_lines == 0 then
    return nil
  end

  -- Current cursor position
  local line = vim.fn.line(".")

  -- Normalised progress (0.0 -> 1.0)
  local progress = line / total_lines

  -- Nerd Font progress blocks (low -> high)
  local blocks = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }

  -- Map progress to a block index
  local index = math.ceil(progress * #blocks)
  index = math.max(1, math.min(index, #blocks))

  return blocks[index]
end

-- Cache to store the statusline components
local cache = {}

-- The Nerd Font icon to render with the component
local branch_icon = " "

---Returns the current Git branch for the working directory.
---
---The Git branch is resolved asynchronously using `git branch --show-current`
---and cached per working directory. While the branch is being resolved,
---the function returns an empty string. Once available, the cached,
---preformatted component is returned.
---
---@return string | nil
---A formatted Git branch string (e.g., " main") or nil if the current
---working directory is not a Git repository.
local get_git_branch = function()
  -- The current directory which is used as the key for caching the the
  -- component's rendering logic
  local cwd = vim.fn.getcwd()

  -- Check if the component is cached
  local cached = cache[cwd]
  if cached ~= nil then
    return cached
  end

  -- Initialise an empty cache if it's not found already
  cache[cwd] = nil

  -- Fetch the branch name from Git
  vim.system({ "git", "branch", "--show-current" }, { text = true }, function(result)
    if result.code == 0 then
      local branch = result.stdout:gsub("%s+", "")
      if branch ~= nil then
        cache[cwd] = branch_icon .. branch
      else
        cache[cwd] = nil
      end
    else
      cache[cwd] = nil
    end

    -- Asynchronously redraw the status if the cache hit was a miss
    vim.schedule(function()
      vim.cmd("redrawstatus")
    end)
  end)

  return nil
end

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
local push_if_present = function(t, ...)
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if v ~= nil then
      t[#t + 1] = v
    end
  end
end

---Renders and returns the complete statusline string.
---
---This function composes the final statusline by concatenating individual
---segments produced by the module's helper functions. The `%=` item is used to
---separate left-aligned and right-aligned sections following Neovim's
---statusline formatting rules. It ignores the rendering logic if the buffer's
---filetype is identified to be "ministarter".
---
---@return string
---The fully formatted statusline string ready to be assigned to the
---`statusline` option.
---
---@see vim.o.statusline
M.render = function()
  -- Mapping of filetypes where the statusline should be disabled
  local disabled_filetypes = { ministarter = true, lazy = true, mason = true }

  -- Get the filetype of the current active buffer
  local buf = vim.api.nvim_win_get_buf(0)
  local ft = vim.bo[buf].filetype

  -- Apply the "Normal" highlight group to the statusline to represent a
  -- "disabled" filetype
  if disabled_filetypes[ft] then
    return "%#Normal#"
  end

  -- Define a table containing the segments of the statusline. These segments
  -- will be concatenated into a singular string later down the line
  local statusline = {}

  -- The current mode
  push_if_present(statusline, get_mode())

  -- The Git branch name segment
  local branch = get_git_branch()
  if branch then
    push_if_present(statusline, "%#StatuslineGitBranch# ", branch, " %*")
  end

  -- The LSP diagnostics segment
  push_if_present(statusline, get_diagnostics())

  -- The filepath segment
  push_if_present(statusline, "%#StatuslineFilePath#", " %f", " %m", "%=", "%*")

  -- The cursor position and related information
  local cursor = get_cursor_glyph()
  if cursor then
    push_if_present(statusline, "L: %l, C: %c ", "%#StatuslineCursorGlyph#", cursor, "%*", " %p%% ")
  end

  return table.concat(statusline)
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
M.setup = function()
  -- Setup the highlight groups
  setup_highlights()

  -- Configure Neovim to evaluate the statusline from the Lua source code
  vim.o.statusline = "%!v:lua.require('statusline').render()"
end

return M
