--[[
Module for configuring the Treesitter plugin for Neovim
For more reference checkout the official repository at:
https://github.com/nvim-treesitter/nvim-treesitter

Additional plugins & modules are available at:
https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
--]]

local M = {}

function M.config()
    require("nvim-treesitter.configs").setup({
        -- Ensure the following parsers are installed by default
        ensure_installed = {
            "bash",
            "lua",
            "markdown",
            "yaml",
            "jsonc",
            "go",
            "toml",
            "typescript",
            "python",
            "tsx",
            "vim",
            "regex",
            "javascript",
            "gomod",
            "html",
            "dockerfile",
            "comment",
        },

        -- Additional modules are also supported, to get a list of those, refer to
        -- the docs available online at:
        -- https://github.com/nvim-treesitter/nvim-treesitter#modules

        -- Feel free to also refer to ":h nvim-treesitter-modules"
        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },

        -- Module powered by "p00f/nvim-ts-rainbow" module
        rainbow = {
            enable = true,
        },
    })
end

return M
