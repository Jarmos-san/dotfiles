-- Module for configuring the "alpha.nvim" dashboard plugin

return {
  {
    "goolord/alpha-nvim", -- Plugin to load a nice dashboard with utilities in the startup screen
    event = "VimEnter", -- Load the plugin right after entering the UI
    opts = function()
      -- Load the configurations for the Alpha dashboard
      local dashboard = require("alpha.themes.dashboard")

      -- Configure some utilitarian buttons to show on the dashboard
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " Create & Open a New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("n", " " .. " Open the File Explorer", "<CMD>Neotree toggle<CR>"),
        dashboard.button("c", " " .. " Configure Local Neovim environment", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "鈴" .. " Open the Lazy Dashboard", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit Out of Neovim", ":qa<CR>"),
      }

      -- Configure some highlight groups for the utilitarian buttons mentioned above
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      -- Logic to show Lazy stats on the Alpha dashboard properly
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          group = vim.api.nvim_create_augroup("show_lazy_on_alpha_ready", { clear = true }),
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts) -- Initiliase the Alpha dashboard with the configurations above

      -- Autocommand to show load times of all the installed plugins right within the Alpha dashboard
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("show_lazy_stats_on_alpha", { clear = true }),
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"

          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
