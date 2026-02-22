---@brief
---
--- This module bootstrap the LSP configurations and setup for the client. It
--- is responsible for discovering the LSP server configuration files located
--- in the runtimepath, extract the server names and add them to the
--- `vim.lsp.enable()` function for discovery and automatic setup. The module
--- also augments the client capabilities using the `blink.cmp` plugin (which)
--- may be replaced in the future with builtin functionalities.

local M = {}

---Discovers all configured LSP servers from the runtimepath.
---
---This function searches every directory in the `runtimepath` for files
---matching - `lsp/*.lua` patterns. Each filename (without the extension) is
---treated as the server name and files named as `init.lua` are ignored.
---
---@return string[] servers list of LSP server names
local get_configured_servers = function()
  -- Fetch all the files containing individual LSP configurations
  local files = vim.api.nvim_get_runtime_file("lsp/*.lua", true)

  -- Initialise an emtpy table which will be populated with the LSP server names
  local servers = {}

  -- Process the filenames and populate the table above
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")

    if name ~= "init" then
      table.insert(servers, name)
    end
  end

  -- Return the populated server names table
  return servers
end

---Initialise and enable all discovered LSP servers.
---
---The `setup` method enables all servers discovered via the
---`get_configured_servers()` function and even extends the LSP client
---capabilities using `blink.cmp`
M.setup = function()
  local servers = get_configured_servers()

  -- Enable all the available LSP servers
  vim.lsp.enable(servers)

  -- Setup and enable the completion capabilities using "blink.cmp"
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- Ensure snippet support is explicitly enabled
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

return M
