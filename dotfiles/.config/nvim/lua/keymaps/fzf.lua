---@brief
---
---Module containing the keymaps for handling various Git VCS capabilities

local telescope = require("telescope.builtin")

---@type DeclarativeKeymap[]
local keymaps = {
  {
    mode = "n",
    lhs = "<leader>ff",
    rhs = telescope.find_files,
    opts = { desc = "List all available files/directories" },
  },
  {
    mode = "n",
    lhs = "<leader>gf",
    -- TODO: Figure a way out to display an error if a Git directory wasn't found
    rhs = telescope.git_files,
    opts = { desc = "List all files and folders tracked inside the Git repository" },
  },
  {
    mode = "n",
    lhs = "<leader>of",
    rhs = telescope.oldfiles,
    opts = { desc = "Open recently opened files" },
  },
  {
    mode = "n",
    lhs = "<leader>b",
    rhs = telescope.buffers,
    opts = { desc = "List all currently in-memory loaded buffers" },
  },
  {
    mode = "n",
    lhs = "<leader>m",
    rhs = telescope.marks,
    opts = { desc = "List all Vim marks registered on the current buffer" },
  },
  {
    mode = "n",
    lhs = "<leader>r",
    rhs = telescope.registers,
    opts = { desc = "Show the contents of the registers" },
  },
  {
    mode = "n",
    lhs = "<leader>h",
    rhs = telescope.help_tags,
    opts = { desc = "Open the help tags menu" },
  },
  {
    mode = "n",
    lhs = "<leader>lg",
    rhs = telescope.live_grep,
    opts = { desc = "Perform a grep on the file contents of the current directory" },
  },
  {
    mode = "n",
    lhs = "<leader>k",
    rhs = telescope.keymaps,
    opts = { desc = "Open a list of available keymaps" },
  },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map.mode, map.lhs, map.rhs, map.opts)
end
