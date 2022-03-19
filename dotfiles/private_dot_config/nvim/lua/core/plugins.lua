--[[
Module for installing plugins
Add, remove or configure plugins as per your needs over here
--]]

-- "packer.nvim" installation path
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

-- Ensure a local clone of "packer.nvim" exists
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- Load "packer.nvim"
vim.cmd([[ packadd! packer.nvim ]])

require("packer").startup({
    function(use)
        use({
            "wbthomason/packer.nvim",
            opt = true,
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            requires = {
                {
                    "p00f/nvim-ts-rainbow",
                    after = "nvim-treesitter",
                },
            },
            run = ":TSUpdate",
            config = function()
                require("confs.treesitter").config()
            end,
        })

        -- TODO: Configure "mini.indentscope to ignore certain buffer types"
        use({
            "echasnovski/mini.nvim",
            branch = "stable",
            config = function()
                require("confs.mini_nvim").config()
            end,
            requires = {
                "kyazdani42/nvim-web-devicons",
                after = "echasnovski/mini.nvim",
            },
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("nvim-tree").setup({})
            end,
        })

        if packer_boostrap then
            require("packer").sync()
        end
    end,
    config = {
        profile = {
            enable = true,
        },
        display = {
            open_fn = function()
                return require("packer.util").float()
            end,
        },
    },
})
