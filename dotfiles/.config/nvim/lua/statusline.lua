-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/posts/neovim-lua-statusline/

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

---Define and register statusline mode highlight groups.
---
---This function creates a set of highlight groups used to visually distinguish
---the current Vim mode in the statusline (Normal, Insert, Visual, Command,
---Replace and Terminal). Each group shares a common background and emphasis
---style while the foreground color varies by mode according to the active
---color palette.
---
---The function is idempotent and safe to call multiple times (e.g., after
---`ColorScheme` autocmds).
---
---@return nil
local define_highlight_groups = function()
  -- Function to set the highlights of a specific capture group
  local hl = vim.api.nvim_set_hl

  -- Set the background colour with decent contrast
  local bg = colors.bg.bg1

  ---@alias StatuslineMode
  ---| "StatuslineModeNormal"
  ---| "StatuslineModeInsert"
  ---| "StatuslineModeVisual"
  ---| "StatuslineModeCommand"
  ---| "StatuslineModeReplace"
  ---| "StatuslineModeTerminal"
  ---
  ---Foreground colors per statusline mode.
  ---
  ---Keys must match the highlight group names consumed by the statusline.
  ---Values are hex color strings.
  ---
  ---@type table<StatuslineMode, string>
  local mode_fg = {
    StatuslineModeNormal = colors.bright.green,
    StatuslineModeInsert = colors.bright.blue,
    StatuslineModeVisual = colors.bright.purple,
    StatuslineModeCommand = colors.bright.yellow,
    StatuslineModeReplace = colors.bright.red,
    StatuslineModeTerminal = colors.bright.aqua,
  }

  -- Loop through the table above and apply all the colours wherever possible
  for group, fg in pairs(mode_fg) do
    hl(0, group, { fg = fg, bg = bg })
  end
end

---@type {[string]: {label: string, hl: string}}
---The various Vim modes and their respective codes as returned by the mode() function.
---See vim.api.nvim_get_mode for more information.
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

---@return string
---Return the current "mode" and return a uppercase formatted string representation.
---@see vim.api.nvim_get_mode
local get_mode = function()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = modes[current_mode] or { label = "UNKNOWN", hl = "StatuslineModeNormal" }

  return string.format("%%#%s# %s ", mode_info.hl, mode_info.label)
end

---@return string
---Get the total number of diagnostic entries in the current buffer and return a nicely
---formatted string with set icons to go with them.
---@see vim.diagnostic
local get_diagnostics = function()
  ---@type {['errors']: integer, ['warnings']: number, ['info']: number, ['hints']: number}
  local count = {
    errors = 0,
    warnings = 0,
    info = 0,
    hints = 0,
  }

  ---@type { [string]: integer }
  local levels = {
    errors = vim.diagnostic.severity.ERROR,
    warnings = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hints = vim.diagnostic.severity.HINT,
  }

  for key, level in pairs(levels) do
    count[key] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError#? " .. count["errors"]
  end

  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end

  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint#? " .. count["hints"]
  end

  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation#? " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

---@return string
---Return the full filename path
local get_filepath = function()
  ---@type string
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %s", fpath)
end

---@return string
---Return the current location of the cursor
local get_cursor_location = function()
  ---@type integer
  local line = vim.fn.line(".")
  ---@type integer
  local column = vim.fn.col(".")

  return string.format("%s:%s", line, column)
end

---@return string
---Return the filetype of the current buffer
local get_filetype = function()
  ---@type string
  local ftype = vim.bo.filetype

  return string.format(" [%s]", ftype)
end

---@return string
---Render the statusline programatically
function M.render()
  return table.concat({
    get_mode(),
    get_diagnostics(),
    get_filepath(),
    "%=",
    get_cursor_location(),
    get_filetype(),
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
  -- Define the highlight groups before Neovim can render the statusline
  define_highlight_groups()

  -- Render the statusline by delegating the task to Lua
  vim.o.statusline = "%!v:lua.require('statusline').render()"
end

return M
