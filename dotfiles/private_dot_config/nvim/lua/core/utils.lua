local M = {}

local fn = vim.fn
local cmd = vim.cmd

-- TODO: Write a better more usable "autocommand" function
-- Functional wrapper for creating AutoGroups
-- function M.create_augroup(autocmds, name)
--     cmd("augroup " .. name)
--     cmd("autocmd!")
--     for _, autocmd in ipairs(autocmds) do
--         cmd("autocmd " .. table.concat(autocmd, " "))
--     end
--     cmd("augroup END")
-- end

-- Functional wrapper for mapping keys
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
