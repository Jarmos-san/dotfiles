---@class Winbar
---@field render fun(): string -- Returns the evaluated winbar setting
---@field setup fun(): nil -- Installs the winbar expression globally
local M = {}

---Render function evaluated by Neovim's winbar engine.
---
---This function is executed every time the winbar is redrawn because it is
---invoked via the `%!` expression mechanism:
---
---   vim.o.winbar = '%!v:lua.require("winbar").render()'
---
---The winbar expression MUST return a string, otherwise returning `nil` will
---render as `v:null`. Returning an empty string (`""`) cleanly suppresses the
---output.
---
---@return string
M.render = function()
  ---Filetypes for which the winbar should be suppressed. Using a set-style
  ---table allows O(1) membership checks.
  ---@type table<string, boolean>
  local disabled_filetypes = {
    ministarter = true,
  }

  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype

  if disabled_filetypes[ft] then
    return ""
  end

  return "Hello World!"
end

---Initialises the global winbar option.
---
---This assigns a Vim expression (`%!`) which evaluates the Lua function on
---every redraw. The option is set globally (using `vim.opt`) so all windows
---inherit it automatically.
---
---NOTE: It should be called once during startup.
---
---@return nil
M.setup = function()
  vim.o.winbar = '%!v:lua.require("winbar").render()'
end

return M
