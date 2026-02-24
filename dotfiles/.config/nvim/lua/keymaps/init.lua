---@brief
---
---Entrypoint moule for registering all Neovim keymaps.
---
---This module serves as an orchestration layer that composes and initialises
---all keymap namespaces in a deterministic order. Each required submodule is
---expected to execute its keymap registration as a side effect of being
---loaded.

local M = {}

M.setup = function()
  require("keymaps.core")
  require("keymaps.terminal")
  require("keymaps.fzf")
  require("keymaps.lsp")
end

return M
