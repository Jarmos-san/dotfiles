---Public entry point for the custom statusline.
---
---@module 'statusline'

---@class Statusline
---@field setup fun(): nil
---@field render fun(): nil

local M = {}

local highlights = require("statusline.highlights")
local modes = require("statusline.components.modes")
local diagnostics = require("statusline.components.diagnostics")
local git = require("statusline.components.git")
local cursor = require("statusline.components.cursor")
local utils = require("statusline.utils")
local disabled = require("statusline.disabled")

---Render the complete statusline.
---
---@return string
M.render = function()
  local buf = vim.api.nvim_win_get_buf(0)
  if disabled.is_disabled(buf) then
    return "%#Normal#"
  end

  local sl = {}

  utils.push_if_present(sl, modes.render())

  local branch = git.render()
  if branch then
    utils.push_if_present(sl, "%#StatuslineGitBranch# ", branch, " %*")
  end

  utils.push_if_present(sl, diagnostics.render())
  utils.push_if_present(sl, "%#StatuslineFilePath#", " %f", " %m", "%=", "%*")

  local cur = cursor.render()
  if cur then
    utils.push_if_present(sl, "L: %l, C: %c ", "%#StatuslineCursorGlyph#", cur, "%*", " %p%% ")
  end

  return table.concat(sl)
end

---Initialise the statusline.
---
---@return nil
M.setup = function()
  highlights.setup()
  vim.o.statusline = "%!v:lua.require('statusline').render()"
end

return M
