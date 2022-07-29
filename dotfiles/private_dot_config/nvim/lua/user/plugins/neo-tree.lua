-- Custom configurations for the "NeoTree" plugin provided by AstroNvim

return {
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      padding = 2,
    },
  },
  window = {
    width = 30,
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        ".git",
        "node_modules",
      },
    },
  },
}
