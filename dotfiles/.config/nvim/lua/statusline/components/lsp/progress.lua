---LSP progress tracking and statusline rendering
---
---This module listens to the `$/progress` LSP notification and maintains a
---per-client progress state used for rendering a dynamic statusline segment.
---
---It defines highlight groups required for rendering the segment and exposes:
---
---   - `lsp_ready()` to check whether at least one LSP client is initialised.
---   - `render_progress()` to return a formatted statusline segment (or nil).
---
---@module "statusline.components.lsp.progress"

local M = {}

local colors = require("statusline.colors").COLORS

local bg = colors.bg.bg0
local fg = colors.bright.blue

-- Set the highlight groups for the segment
vim.api.nvim_set_hl(0, "StatuslineLspProgress", { fg = fg, bg = bg })

---Represents the LSP work-done progress payload
---
---@class LspProgressValue
---@field kind '"begin"'|'"report"'|'"end"'
---@field title? string
---@field message? string
---@field percentage? integer

---Internal map of active LSP progress states indexed by client ID.
---
---@type table<integer, LspProgressValue>
local progress_state = {}

---@type string[]
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

---@type integer
local spinner_interval = 80

---Returns the current spinner frame.
---
---Frame index is derived from high-resolution monotonic time, making
---animations deterministic and timer-free.
---
---@return string
local current_spinner_frame = function()
  local now_ns = vim.uv.hrtime()
  local frame = math.floor((now_ns / 1e6) / spinner_interval)
  local index = (frame % #spinner_frames) + 1
  return spinner_frames[index]
end

---Overrides the default `$/progress` handler.
---
---Tricks the latest progress notification per client and updates the
---statusline accordingly. Progress entries are inserted on `"begin"` and
---`"report"` events and removed on `"end"`.
---
---@param _ lsp.ResponseError?
---@param result table
---@param ctx lsp.HandlerContext
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return nil
  end

  local val = result.value
  if type(val) ~= "table" then
    return nil
  end

  ---@cast val LspProgressValue

  if val.kind == "begin" or val.kind == "report" then
    progress_state[client.id] = val
  elseif val.kind == "end" then
    progress_state[client.id] = nil
  end

  vim.cmd("redrawstatus")
end

---Determins whether at least one LSP client is initialised and active.
---
---@return boolean
---`true` if a client is initialised and not stopped, otherwise `false`.
M.is_ready = function()
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.initialized and not client:is_stopped() then
      return true
    end
  end
  return false
end

---Builds the statusline segment for active LSP progress
---
---if at least one client has an active progress state, the first available
---entry is rendered. When no active progress exists, `nil` is returned.
---
---@return string|nil
---A formatted statusline segment or `nil` if no progress is active.
M.render = function()
  for _, val in pairs(progress_state) do
    local msg = val.message or val.title or ""

    if val.percentage then
      msg = string.format("%s (%d%%%%)", msg, val.percentage)
    end

    local spinner = current_spinner_frame()

    return string.format("%%#StatuslineLspProgress# %s %s %%*", spinner, msg)
  end

  return nil
end

return M
