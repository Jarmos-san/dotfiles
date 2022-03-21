--[[
Module for configuring the file explorer plugin "kyazdani42/nvim-tree"

For more info check the docs at - ":h nvim_tree"
--]]

local M = {}

local map = require("core.utils").map

function M.setup()
    -- TODO: Enable a couple of keybindings over here
    map("n", "<C-n>", ":NvimTreeToggle<CR>")
end

function M.config()
    -- TODO: Configure "kyazdani/nvim-tree" as per requirements
    require("nvim-tree").setup({})
end

return M
