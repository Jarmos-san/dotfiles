-- Module for mapping some custom keybindings with option to show them
-- on a nice popup menu using the "which-key" plugin.

return {
  -- first key is the mode, n == normal mode
  n = {
    -- second key is the prefix, <leader> prefixes
    ["<leader>"] = {
      -- which-key registration table for normal mode, leader prefix
      -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
    },
  },
}
