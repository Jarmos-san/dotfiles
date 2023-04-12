-- Path to install "lazy.nvim" at
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local highlight = vim.api.nvim_set_hl

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

-- Load the necessary user-defined Lua modules here for customising Neovim.
require("configs.options")
require("configs.autocmds")
require("configs.keymaps")

vim.cmd([[ colorscheme onedark ]])

-- TODO: Figure a way out to move these highlights to a separate file elsewhere(?)
highlight(0, "CursorLineNr", { guibg = nil, guifg = nil })
highlight(0, "CursorLine", { guibg = nil })

-- Additional features to look into later on:
-- https://github.com/neovim/neovim/pull/22668
-- https://github.com/rafcamlet/nvim-luapad
