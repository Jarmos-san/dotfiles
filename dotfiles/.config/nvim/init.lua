-- Path to install "lazy.nvim" at
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Small snippet to install "lazy.nvim" from within Neovim.
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Update the Neovim runtimepath for "lazy.nvim" to source the plugins.
vim.opt.rtp:prepend(lazypath)

-- Map the <Leader> key to <Space>.
vim.g.mapleader = " "

-- Disable some in-built features which are unnecessary (and probably affects performance?)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Install the necessary plugins through "lazy.nvim"
require("lazy").setup("plugins", {
  defaults = { lazy = true }, -- Make all plugins to be lazy-loaded.
  ui = {
    border = "rounded", -- Enable rounded borders for the "lazy.nvim" UI.
  },
  performance = {
    rtp = {
      disabled_plugins = { -- Disable certain in-built plugins which are useful af.
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rplugin",
        "man",
        "spellfile",
      },
    },
  },
})

-- Safely load the necessary user-defined Lua modules meant to customise Neovim.
for _, module in ipairs({ "options", "autocmds", "keymaps" }) do
  local ok, error = pcall(require, module)

  if not ok then
    print("Error loading module: " .. error)
  end
end

-- My WIP personalised colour scheme
-- vim.cmd.colorscheme("shinkai")

vim.cmd.colorscheme("onedark")
-- The follow two colourschems are the most popular ones right now with support for semantic highlighting
-- vim.cmd([[ colorscheme tokyonight]])
-- vim.cmd.colorscheme("catppuccin")

-- INFO: Enable an experimental fast module loader. See the PR for more information:
-- https://github.com/neovim/neovim/pull/22668
vim.loader.enable()

-- Additional features to look into later on:
-- https://github.com/rafcamlet/nvim-luapad

-- INFO: Good book to learn Vim from;
-- https://learnvim.irian.to/
