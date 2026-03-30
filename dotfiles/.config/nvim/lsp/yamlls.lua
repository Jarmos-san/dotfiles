---@brief
---
--- https://github.com/redhat-developer/yaml-language-server
---
--- The LSP server can be installed via:
--- ```sh
--- pnpm add --global yaml-language-server
--- ```

---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    redhat = {
      telemetry = {
        enable = false,
      },
    },
    yaml = {
      format = {
        enable = true,
      },
    },
    schemas = require("schemastore").yaml.schemas(),
    validate = true,
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
