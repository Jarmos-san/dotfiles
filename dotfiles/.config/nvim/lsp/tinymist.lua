-- LSP configurations for the "tinymist" LSP server to be used by Typst files
-- TODO: Add the user commands to invoke some of the inbuilt tinymist commands
return {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  root_markers = { ".git" },
  settings = {
    formatterMode = "typstyle",
  },
}
