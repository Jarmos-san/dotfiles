-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

---@class Statusline
---@field render fun(): string
local M = {}

---@type {[string]: string}
---The various Vim modes and their respective codes as returned by the mode() function.
---See vim.api.nvim_get_mode for more information.
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  ["nt"] = "TERMINAL",
}

---@return string
---Return the current "mode" and return a uppercase formatted string representation.
---@see vim.api.nvim_get_mode
local get_mode = function()
  ---@type string
  local current_mode = vim.api.nvim_get_mode().mode

  return string.format(" %s", modes[current_mode]:upper())
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

return M
