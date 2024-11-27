-- Filetype plugin module for configuring Python development in Neovim
-- Refer to the resource shared below for further inspiration
-- https://github.com/aikow/dotfiles/blob/main/config/nvim/after/ftplugin/python.lua

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local map = require("utils").map

-- INFO: Local keymap (specific to Python files) to execute the current Python script
if os.getenv("VIRTUAL_ENV") ~= nil then
  map("n", "<F2>", "<CMD>terminal pytest %<CR>")
  map("n", "<F5>", "<CMD>terminal python %<CR>")
else
  map("n", "<F5>", "<CMD>terminal python3 %<CR>")
end

autocmd({ "BufWritePost" }, {
  desc = "Lint buffer contents after writing them",
  group = augroup("lint_python_files"),
  callback = function()
    require("lint").try_lint()
  end,
})

-- Wrap words at the EOL "cleanly" (i.e) ensure the words are wrapped and not just characters
vim.opt.wrap = true
vim.opt.linebreak = true

-- Configure the indent-based folds for Python buffers
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 1
