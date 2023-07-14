-- Module for configuring the "terminal.nvim" plugin

local M = {}

M.init = function()
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = function(name)
    return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
  end

  -- Autocommand to ensure the Neovim gets into Insert mode automatically when
  -- the terminal is toggled open.
  autocmd("TermOpen", {
    desc = "Get into Insert mode automatically when the terminal is open",
    group = augroup("terminal_insert_mode"),
    callback = function(args)
      if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
        vim.cmd("startinsert")
      end
    end,
  })

  -- Disable the number column & enable some highlights for the terminal
  autocmd("TermOpen", {
    desc = "Disable number coloum on the terminal",
    group = augroup("terminal_highlights"),
    callback = function()
      -- Disable the number column in the terminal
      vim.opt.number = false
      vim.opt.relativenumber = false
      -- Set some highlightings for the floating window
      vim.api.nvim_win_set_option(0, "winhl", "Normal:NormalFloat")
    end,
  })
end

M.config = function()
  require("terminal").setup({
    layout = {
      -- Open the terminal in a vertical split
      open_cmd = "vnew",
    },
    -- cmd = { vim.o.shell },
    -- Close the terminal as well when the shell process is exited
    -- autoclose = false,
  })
end

return M
