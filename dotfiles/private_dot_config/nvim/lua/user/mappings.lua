return {
  -- The first key is the mode. For example, below "n" is for "Normal" mode.
  n = {
    -- The second keys are the "LHS" for the mapping. See ":h map" for more info.
    ["<C-s>"] = { ":w!<CR>", desc = "Save file" },
    ["<C-a>"] = { "ggVG", desc = "Select all texts in a buffer." },
  },
  -- t = {
  --   -- Setting a mapping to false will disable it.
  --   ["<ESC>"] = false,
  -- },
}
