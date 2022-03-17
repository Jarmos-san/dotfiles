--[[
Module for configuring the Treesitter plugin for Neovim
For more reference checkout the official repository at:
https://github.com/nvim-treesitter/nvim-treesitter
--]]

local M = {}

function M.config()
	require("nvim-treesitter.configs").setup({
		-- Ensure the following parsers are installed by default
		ensure_installed = {
			"lua",
			"markdown",
			"yaml",
			"jsonc",
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
	})
end

return M
