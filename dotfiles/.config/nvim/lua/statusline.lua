-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/posts/neovim-lua-statusline/

---@class Statusline
---@field render fun(): string
---@field setup fun(): nil
local M = {}

---@return nil
local define_highlight_groups = function()
  vim.api.nvim_set_hl(0, "StatuslineModeNormal", { fg = "#282c34", bg = "#98c379", bold = true })
  vim.api.nvim_set_hl(0, "StatuslineModeInsert", { fg = "#282c34", bg = "#61afef", bold = true })
  vim.api.nvim_set_hl(0, "StatuslineModeVisual", { fg = "#282c34", bg = "#c678dd", bold = true })
  vim.api.nvim_set_hl(0, "StatuslineModeCommand", { fg = "#282c34", bg = "#e5c07b", bold = true })
  vim.api.nvim_set_hl(0, "StatuslineModeReplace", { fg = "#282c34", bg = "#e06c75", bold = true })
  vim.api.nvim_set_hl(0, "StatuslineModeTerminal", { fg = "#282c34", bg = "#56b6c2", bold = true })
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

---@return nil
function M.setup()
  define_highlight_groups()
  vim.o.statusline = "%!v:lua.require('statusline').render()"
end

return M
