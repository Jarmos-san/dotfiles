-- Configurations for 'kyazdani42/nvim-tree.lua' plugin
-- For more info check out "h: nvim-tree.lua"

local M = {}

function M.config()

    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_quit_on_open = 1
    vim g.nvim_tree_markers = 1
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_ignore = {
        '.git', 'node_modules', '.cache', '__pycache__'
    }
    vim.g.nvim_show_tree_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0,
    }
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git_icons = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '★',
            deleted = '',
            ignored = '◌',
        },
        folder_icons = {
            arrow_closed = '',
            arrow_open = '',
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            symlink_open = '',
        },
        lsp = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    }

    require('nvim-tree').setup {
        auto_close = true,
        update_cwd = true,
        lsp_diagnostics = true,
        view = {
            width = 30,
            side = 'left',
            auto_resize = false,
            mappings = {
                list = {
                -- TODO: Add some custom keymaps here
                },
            },
        },
    }

    -- Colorscheme concerns
    vim.cmd [[
        highlight link NvimTreeIndentMarker whitespace
        highlight link NvimTreeFolderIcon NonText
    ]]

    -- Lazy load NvimTree
    require('nvim-tree.events').on_nvim_tree_ready(function()
        vim.cmd 'NvimTreeRefresh'
    end)
end

function M.setup()
    local map = require('utils').map

    map('n', '<C-b>', '<CMD>NvimTreeToggle<CR>')
end

return M
