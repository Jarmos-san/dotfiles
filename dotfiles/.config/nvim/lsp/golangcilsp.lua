---@brief
---
--- https://github.com/nametake/golangci-lint-langserver
---
--- A LSP server for the golangci-lint tool.

---@type vim.lsp.Config
return {
  cmd = { "golangci-lint-langserver" },
  root_markers = { ".golangci.yml", "go.mod", ".git" },
  init_options = {
    command = {
      "golangci-lint",
      "run",
      "--output.json.path",
      "stdout",
      "--show-stats=false",
      "--issues-exit-code=1",
    },
  },
}
