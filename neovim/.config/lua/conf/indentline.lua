-- Configurations for 'lukas-reineke/indent-blankline.nvim' plugin

local M = {}

function M.config()
    vim.g.indent_blankline_char = '▏'
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_filetype_exclude = {
        'help', 'markdown', 'gitcommit', 'packer'
    }
    vim.g.indent_blankline_buftype_exclude = {
        'terminal', 'nofile'
    }
    -- TODO: Uncomment the following line after nvim-treesitter is installed
    -- vim.g.indent_blankline_use_treesitter = true
end

return M
