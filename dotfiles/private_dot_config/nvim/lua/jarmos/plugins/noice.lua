--[[
Module for configuring the improved Neovim UI/UX.
--]]

local M = {}

function M.config()
  require("noice").setup({
    cmdline = {
      view = "cmdline",
    },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
  })
end

return M
