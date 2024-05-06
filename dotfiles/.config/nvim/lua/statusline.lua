-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local M = {}

-- Return the current "mode" in Neovim (see ":h mode" for more info on this regards)
local mode = function()
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
  }

  local current_mode = vim.api.nvim_get_mode().mode

  return string.format(" %s", modes[current_mode]:upper())
end

-- Return the LSP diagnostics info from the client to the statusline
local diagnostics = function()
  -- Initialise the count of the diagnostic information returned by the client
  local count = {}

  -- The levels of severity of the LSP diagnostics
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for key, level in pairs(levels) do
    count[key] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end

  if count["warnings"] ~= 0 then
    errors = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end

  if count["hints"] ~= 0 then
    errors = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end

  if count["info"] ~= 0 then
    errors = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

-- Return the full filename path
local filepath = function()
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %s", fpath)
end

-- Return the current location of the cursor
local cursor_location = function()
  local line = vim.fn.line(".")
  local column = vim.fn.col(".")

  return string.format("%s:%s", line, column)
end

-- Return the filetype of the current buffer
local filetype = function()
  local ftype = vim.bo.filetype

  return string.format(" [%s]", ftype)
end

-- Render the statusline programatically
function M.render()
  return table.concat({
    mode(),
    diagnostics(),
    filepath(),
    "%=",
    cursor_location(),
    filetype(),
  })
end

return M
