local M = {}

local fn = vim.fn
local cmd = vim.cmd

-- Functional wrapper for creating Autogroups
function M.create_augroup(autocmds, name)
    cmd('augroups ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
	cmd('autocmd ' .. table.concat(autocmd, ''))
    end
    cmd('augroup END')
end

-- Functional wrapper for mapping keys
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
	options = vim.tbl_extend('force', options, opts)
    end
    
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)

end

-- Check if buffer is empty or not
function M.is_buffer_empty()
    return vim.fn.empty(vim.fn.expand '%:t') == 1
end

-- Check if the window width is greater than the given number of columns
function M.has_width_gt()
    return vim.fn.winwidth(0) / 2 > cols
end

return M
