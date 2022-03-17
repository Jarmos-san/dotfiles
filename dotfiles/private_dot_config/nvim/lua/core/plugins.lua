--[[
Module for installing plugins
Add, remove or configure plugins as per your needs over here
--]]

local execute = vim.nvim_exec_command

-- "packer.nvim" installation path
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

-- Ensure a local clone of "packer.nvim" exists
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

-- Load "packer.nvim"
vim.cmd([[ packadd! packer.nvim ]])

require('packer').startup(function(use)

    use {
        'wbthomason/packer.nvim',
        opt = true
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    if packer_boostrap then
        require('packer').sync()
    end

end)
