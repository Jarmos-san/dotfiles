-- Module for configuring Lua specific buffer contents

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local format = require("utils").format

autocmd("BufWritePost", {
  desc = "Format the buffer contents after save",
  group = augroup("format_buffer_contents"),
  callback = function()
    local stylua_command = "silent !stylua % --stdin-filepath %"

    format(stylua_command)
  end,
})
