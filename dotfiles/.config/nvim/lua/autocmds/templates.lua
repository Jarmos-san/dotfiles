-- This module defines a declarative mapping between filename patterns and
-- skeleton template files. When a new file is created (`BufNewFile`) and its
-- path matches one of the configured patterns, the corresponding template file
-- is inserted at the top of the buffer.

-- A mapping of filepaths and their skeletons which Neovim uses to render the
-- initial content for a fresh new buffer
local templates = {
  ["**/.editorconfig"] = "editorconfig.txt",
  ["**/README.md"] = "readme.md",
  ["**/.github/dependabot.yml"] = "dependabot.yml",
  ["**/.github/workflows/*.yml"] = "github-workflow.yml",
  ["**/Taskfile.yml"] = "taskfile.yml",
  ["**/main.py"] = "main.py",
  ["**/LICENSE"] = "license.txt",
  ["*.vue"] = "sfc.vue",
}

-- Iterate through the map and create the autocommands to generate the skeleton
-- contents of the files
for pattern, file in pairs(templates) do
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("templates", { clear = true }),
    pattern = pattern,
    command = ("0r ~/.config/nvim/skeletons/%s"):format(file),
  })
end
