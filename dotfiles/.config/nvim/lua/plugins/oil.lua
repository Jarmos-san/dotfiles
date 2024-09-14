return {
  "stevearc/oil.nvim",
  ---@module'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("oil").setup()
  end,
  keys = {
    { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
  },
}
