---Public entry point for the custom statusline.
---
---@module 'statusline'

---@class Statusline
---@field setup fun(): nil
---@field active fun(): string
---@field inactive fun(): string

local M = {}

local highlights = require("statusline.highlights")
local modes = require("statusline.components.modes")
local diagnostics = require("statusline.components.diagnostics")
local git = require("statusline.components.git")
local cursor = require("statusline.components.cursor")
local utils = require("statusline.utils")
local disabled = require("statusline.disabled")

---Render the statusline for the active window.
---
---This functio is evaluated by Neovim via the `%!` statusline expression. It
---builds the statusline incrementally by concatenating rendered segments such
---as mode, Git branches, diagnostics, file path and cursor information.
---
---If the current buffer is marked as disabled, the default `Normal` highlight
---group is returned and no custom rendering is applied.
---
---@return string
M.active = function()
  ---@type integer
  local buf = vim.api.nvim_win_get_buf(0)

  if disabled.is_disabled(buf) then
    return "%#Normal#"
  end

  ---@type string[]
  local statusline = {}

  -- Mode segment (e.g., NORMAL / INSERT / VISUAL and so on)
  utils.push_if_present(statusline, modes.render())

  -- Git branch segment (optional)
  ---@type string | nil
  local branch = git.render()
  if branch then
    utils.push_if_present(statusline, "%#StatuslineGitBranch#", branch, " %*")
  end

  -- Diagnostics segment (LSP warning/errors, optional)
  utils.push_if_present(statusline, diagnostics.render())

  -- Filepath and modified flag; `%=` seperates the left and right segments
  utils.push_if_present(statusline, "%#StatuslineFilePath#", " %f", " %m", "%=", "%*")

  -- Cursor position and percentage through file (optional)
  ---@type string | nil
  local cur = cursor.render()
  if cur then
    utils.push_if_present(statusline, "L: %l, C: %c ", "%#StatuslineCursorGlyph#", cur, "%*", " %p%% ")
  end

  return table.concat(statusline)
end

---Render the statusline for an inactive window.
---
---The inactive statusline is intentionally minimal and typically displays only
---the filepath and modified flag. This reduces visual noise while preserving
---essential context for an unfocused window.
---
---If the current buffer is marked as disabled, the default `Normal` highlight
---group is returned.
---
---@return string
M.inactive = function()
  ---@type integer
  local buf = vim.api.nvim_win_get_buf(0)

  if disabled.is_disabled(buf) then
    return "%#Normal#"
  end

  ---@type string[]
  local statusline = {}

  utils.push_if_present(statusline, "%#StatuslineFilePath#", " %f", " %m", "%=", "%*")

  return table.concat(statusline)
end

---Initialise the statusline.
---
---This function creates an augroup to manage all statusline-related
---autocommands. Registers highlight groups used by the statusline segments and
---attaches a window-local statusline renderer for the active and inactive
---windows.
---
---The statusline is rendered dynamically via the `%!v:lua.require(...)`
---expressions ensuring it updates on every redraw.
---
---@return nil
M.setup = function()
  local augroup = vim.api.nvim_create_augroup("Statusline", { clear = true })
  local autocmd = vim.api.nvim_create_autocmd

  -- Setup the highlight groups for the statusline segments
  highlights.setup()

  -- Render the statusline for the active window
  autocmd({ "WinEnter", "BufEnter" }, {
    group = augroup,
    callback = function()
      vim.opt_local.statusline = '%!v:lua.require("statusline").active()'
    end,
  })

  -- Render the statusline for the inactive window
  autocmd({ "WinLeave", "BufLeave" }, {
    group = augroup,
    callback = function()
      vim.opt_local.statusline = '%!v:lua.require("statusline").inactive()'
    end,
  })
end

return M
