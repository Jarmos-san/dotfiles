--[[
Module for configuring the "mini.nvim" plugin

Find more documentation details at the following url:
https://github.com/echasnovski/mini.nvim
--]]

local M = {}

function M.config()
    -- see ":h mini.statement" for info on configuring the statusline
    require("mini.statusline").setup({})

    -- see ":h mini.indentscope" for info on configuring the indentlines
    require("mini.indentscope").setup({})

    -- see ":h mini.tabline" & ":h tabline" for info on configuring the tabline
    require("mini.tabline").setup({})

    -- see ":h mini.pairs" for configuring auto-paring expressions like quotes & brackets
    require("mini.pairs").setup({})

    -- see ":h mini.comment" for configuring how you (un)comment code
    require("mini.comment").setup({})

    -- see ":h mini.cursorword" for configuring the aesthetics of the word under the cursor
    require("mini.cursorword").setup({})
end

return M
