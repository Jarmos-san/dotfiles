-- Generate a base template to build upon when working with Shell files.
local create_skeleton_group = vim.api.nvim_create_augroup("create_skeletons", { clear = true })
-- INFO: Generate the template file for Bash/Shell files.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  group = create_skeleton_group,
  command = "0r ~/.config/nvim/templates/bash.sh",
})
