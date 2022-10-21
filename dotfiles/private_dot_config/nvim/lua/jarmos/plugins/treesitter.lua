--[[
Module for configuring the Treesitter plugin in Neovim.
--]]

--[[ TODO: Add a couple more Treesitter-based plugins & configure them. ]]

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "gitattributes",
      "gitignore",
      "go",
      "gomod",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "scss",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "yaml",
    },
    highlight = { enable = true },
    incremental_selection = { enable = false },
    indent = { enable = false },
    folding = { enable = false },
    -- INFO: Configurations for "bracket coloriser" plugin
    -- https://github.com/p00f/nvim-ts-rainbow
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
    -- INFO: Configurations for the autotag plugin
    -- https://github.com/windwp/nvim-ts-autotag
    autotag = {
      enable = true,
    },
  })
end

return M
