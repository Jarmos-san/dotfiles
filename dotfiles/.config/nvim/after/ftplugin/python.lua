-- Filetype plugin module for configuring Python development in Neovim
-- Refer to the resource shared below for further inspiration
-- https://github.com/aikow/dotfiles/blob/main/config/nvim/after/ftplugin/python.lua

local autocmd = require("utils").autocmd
local augroup = require("utils").augroup
local map = require("utils").map
local format = require("utils").format

-- INFO: Local keymap (specific to Python files) to execute the current Python script
if os.getenv("VIRTUAL_ENV") ~= nil then
  map("n", "<F2>", "<CMD>terminal pytest % -vv<CR>")
  map("n", "<F5>", "<CMD>terminal python %<CR>")
else
  map("n", "<F5>", "<CMD>terminal python3 %<CR>")
end

autocmd("BufWritePost", {
  desc = "Format buffer contents after writing them",
  group = augroup("format_python_files"),
  callback = function()
    -- INFO: Command to invoke black from within Neovim
    local black_command = "silent !black " .. bufname .. " --stdin-filename" .. bufname .. " --quiet"

    -- INFO: Run the formatting command on the buffer contents if the venv is activated
    if os.getenv("VIRTUAL_ENV") == nil then
      vim.notify("[WARN] Please activate the virtual environment first!", vim.log.levels.WARN)
    else
      format(black_command)
    end

    -- INFO: If "black" exited with an error, undo the changes to the previous state
    if not vim.g.shell_error == 0 then
      vim.cmd("undo")
    end
  end,
})

autocmd({ "BufWritePost" }, {
  desc = "Lint buffer contents after writing them",
  group = augroup("lint_python_files"),
  callback = function()
    require("lint").try_lint()
  end,
})
