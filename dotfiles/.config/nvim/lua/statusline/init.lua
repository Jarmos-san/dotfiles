---Public entry point for the custom statusline.
---
---@module 'statusline'

---@class Statusline
---@field setup fun(): nil
---@field render fun(): string

local M = {}

local modes = require("statusline.components.modes")
local git = require("statusline.components.git")
local cursor = require("statusline.components.cursor")
local diagnostic = require("statusline.components.diagnostics")

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
M.render = function()
  -- Reset the foreground colour of the statusline
  vim.api.nvim_set_hl(0, "Statusline", { fg = "#000000" })

  -- Disabled filetypes
  local disabled_filetypes = {
    ministarter = true,
    lazy = true,
    mason = true,
    TelescopePrompt = true,
  }

  -- Make the statusline disappear for certain filetypes.
  local buf = vim.api.nvim_win_get_buf(0)
  if disabled_filetypes[vim.bo[buf].filetype] then
    return "%*"
  end

  -- Render the various segments along with their highlights
  local mode = modes.render()
  local git_branch = git.render()
  local cursor_segment = cursor.render()
  local diagnostic_segment = diagnostic.render()

  -- Create an empty statusline segment to which the segments will be appended to
  local statusline = {}

  -- The Vim mode segment
  if mode ~= nil then
    table.insert(statusline, mode)
  end

  -- The Git branch segment
  if git_branch ~= nil then
    table.insert(statusline, git_branch)
  end

  -- The diagnostic icons/count
  if diagnostic_segment ~= nil then
    table.insert(statusline, diagnostic_segment)
  end

  -- The cursor status and related information
  if cursor ~= nil then
    table.insert(statusline, cursor_segment)
  end

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
  -- Render the statusline with autocommand so that the highlights are applied uniformly
  -- even after switching windows
  vim.api.nvim_create_autocmd({ "WinLeave", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("Statusline", { clear = true }),
    callback = function()
      vim.opt_local.statusline = '%!v:lua.require("statusline").render()'
    end,
  })
end

return M
