-- Module for configuring the "trouble.nvim" plugin

return {
  "folke/trouble.nvim",
  event = "LspAttach",
  cmd = "Trouble",
  config = true,
  dependencies = "devicons",
}
