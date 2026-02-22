---@brief
---
---Module for configuring the core LSP capabilities of the clients. The
---configurations for the LSP server are located at the `/lsp` directory from
---where they're autoconfigured by the client.

local M = {}

M.setup = function()
  -- Enable all the available LSP servers
  vim.lsp.enable({ "lua_ls", "fish_lsp", "pyright" })

  -- Setup and enable the completion capabilities using "blink.cmp"
  -- TODO: In the near future, replace the plugin with builtin capabilities
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

return M
