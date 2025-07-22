-- Configurations for "vale-ls", the LSP for Vale (a linter for prose)
return {
  cmd = { "vale-ls" },
  filetypes = { "markdown", "text", "rst" },
  root_markers = { ".vale.ini" },
}
