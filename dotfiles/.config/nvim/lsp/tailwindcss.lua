---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "tailwind.config.js", "package.json", ".git" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
      },
    },
  },
}
