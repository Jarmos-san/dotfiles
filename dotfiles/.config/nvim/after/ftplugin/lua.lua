-- Module for configuring Lua specific buffer contents

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("BufWritePre", {
  desc = "Format Lua files using Stylua",
  group = augroup("format_lua_files"),
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
