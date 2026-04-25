-- Module for configuring Lua specific buffer contents

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup

autocmd("BufWritePost", {
  desc = "Lint Lua files using Stylua",
  group = augroup("lint_lua_files"),
  callback = function()
    require("lint").try_lint()
  end,
})

-- Start the Treesitter parser process
vim.treesitter.start()

-- Enable the LSP capabilities
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
