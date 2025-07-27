return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  root_markers = { ".git" },
  settings = {
    redhat = {
      telemetry = false,
    },
    schemas = require("schemastore").yaml.schemas(),
    validate = true,
  },
}
