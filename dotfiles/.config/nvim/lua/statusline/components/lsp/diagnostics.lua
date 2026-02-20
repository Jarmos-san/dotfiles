---LSP diagnostics aggregation and rendering.
---
---This module queries diagnostics for the current buffer and renders non-zero
---severity counts as statusline segments.
---
---@module "statusline.components.lsp.diagnostics"
local M = {}

-- Setup the highlights for the LSP diagnostic icons
local hl = vim.api.nvim_set_hl
local colors = require("colors").colors
local bg = colors.bg.bg0_h

hl(0, "LspDiagnosticsSignError", { fg = colors.bright.red, bg = bg })
hl(0, "LspDiagnosticsSignWarning", { fg = colors.bright.yellow, bg = bg })
hl(0, "LspDiagnosticsSignHint", { fg = colors.bright.green, bg = bg })
hl(0, "LspDiagnosticsSignInfo", { fg = colors.bright.blue, bg = bg })

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
---@return string|nil
---A formatted statusline segment containing zero or more diagnostic
---indicators.
---
---@see vim.diagnostic
M.render = function()
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
    segments[#segments + 1] = string.format("%%#LspDiagnosticsSignError# ε %s %%*", count.errors)
  end

  if count.warnings > 0 then
    segments[#segments + 1] = string.format("%%#LspDiagnosticsSignWarning#  %s %%*", count.warnings)
  end

  if count.hints > 0 then
    segments[#segments + 1] = string.format("%%#LspDiagnosticsSignHint#  %s %%*", count.hints)
  end

  if count.info > 0 then
    segments[#segments + 1] = string.format("%%#LspDiagnosticsSignInfo#  %s %%*", count.info)
  end

  return table.concat(segments)
end

return M
