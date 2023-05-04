-- Module for configuring the "alpha" plugin (for the startup dashboard)

local M = {}

M.init = function()
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = function(name)
    return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
  end

  autocmd("User", {
    desc = "Open Alpha dashboard when all buffers are removed",
    group = augroup("open_alpha_on_buffer_removal"),
    pattern = "BDeletePost*",
    callback = function(event)
      local fallback_name = vim.api.nvim_buf_get_name(event.buf)
      local fallback_filetype = vim.api.nvim_buf_get_option(event.buf, "filetype")
      local fallback_on_empty = fallback_name == "" and fallback_filetype == ""

      if fallback_on_empty then
        vim.cmd("Neotree close")
        vim.cmd("Alpha")
        vim.cmd(event.buf .. "bwipeout")
      end
    end,
  })
end

M.config = function()
  -- Load a default provided dashboard for easy access to recently opened files
  local dashboard = require("alpha.themes.dashboard")
  require("alpha").setup(dashboard.config)
end

return M
