---Winbar rendering module.
---
---This module provides a custom winbar which displays the current buffer's
---filepath and a modified indicator with per segment highlights.
---
---@module 'winbar'
local M = {}

---Define and apply highlight groups used by the winbar.
---
---The highlight groups and their purposes are as follows:
---   * `Winbar`                : Base background highlight.
---   * `WinbarFilepath`        : Filepath segment highlight.
---   * `WinbarModifiedGlyph`   : Modified indicator highlight.
---
---@return nil
local setup_highlights = function()
  ---@type table<string, vim.api.keyset.highlight>
  local highlights = {
    Winbar = { bg = "#3c3836" },
    WinbarFilepath = { fg = "#fabd2f" },
    WinbarModifiedGlyph = { fg = "#fe8019" },
  }

  for name, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, spec)
  end
end

---Create a styled filepath string for the winbar.
---
---The filepath is resolved from the current buffer using the statusline
---expansion flag (`%f`) and then transformed to use a custom seperator
---(requires Nerd Font).
---
---@return string filepath The styled filepath string.
local create_filepath = function()
  ---@type string
  local filepath = vim.api.nvim_eval_statusline("%f", {}).str

  ---@type string
  local styled = filepath:gsub("/", "  ")

  return styled
end

---Render the winbar contents.
---
---This function is evaluated by Neovim once per window when assigned to
---`vim.o.winbar`. It returns a statusline-format string containing highlight
---groups and segments.
---
---The segments are as follows:
---   * Filepath (always shown).
---   * Modified glyph (shown only when buffer is modified).
---
---@return string winbar The statusline-formatted winbar string.
M.render = function()
  ---@type string[]
  local segments = {}

  -- Filepath segment with highlight
  ---@type string
  local filepath = "%#WinbarFilepath#" .. " " .. create_filepath() .. " "

  -- Modified indicator segment (optional)
  ---@type string|nil
  local modified
  if vim.bo.modified then
    modified = "%#WinbarModifiedGlyph# %#Winbar#"
  end

  table.insert(segments, filepath)
  table.insert(segments, modified)

  ---@type string
  local winbar = table.concat(segments)

  ---Filetypes for which the winbar should be disabled
  ---@type table<string, boolean>
  local disabled_filetypes = { ministarter = true, lazy = true, mason = true, ["TelescopePrompt"] = true }
  if not disabled_filetypes[vim.bo.filetype] then
    return winbar
  else
    return "%#Normal#"
  end
end

---Initialise the winbar module.
---
---This function applies the highlight group and registers the winbar render
---function using a Lua expression which Neovim can evaluate once.
M.setup = function()
  -- Setup the highlight groups
  setup_highlights()

  -- Assign the Lua-rendered winbar expression.
  vim.o.winbar = "%!v:lua.require('winbar').render()"
end

return M
