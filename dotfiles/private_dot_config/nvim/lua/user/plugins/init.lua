return {
  -- Add plugins, the packer syntax without the "use"
  init = {
    -- Plugin for setting a colour scheme which doesn't hurt the eyes.
    {
      "navarasu/onedark.nvim",
      config = function()
        require("onedark").setup({ style = "warmer", diagnostics = { darker = false } })
        require("onedark").load()
      end,
    },
    -- Plugin for better LSP support while working with TypeScript
    {
      "jose-elias-alvarez/typescript.nvim",
      after = "nvim-lsp-installer",
      config = function()
        require("typescript").setup({
          server = astronvim.lsp.server_settings("tsserver"),
        })
      end,
    },
    -- Plugin for previewing Markdown files right within Neovim.
    {
      "ellisonleao/glow.nvim",
      config = function()
        require("glow").setup({
          glow_path = "glow",
          border = "",
          pager = true,
          width = 90,
        })
      end,
    },
  },
}
