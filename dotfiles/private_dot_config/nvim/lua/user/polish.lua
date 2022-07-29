-- A couple of stuff like autocommands to run at last for performance gains.

return function()
  -- Autocommand for sourcing the "/user/init.lua" file after saving it.
  vim.api.nvim_create_augroup("packer_conf", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Sync packer after modifying plugins.lua",
    group = "packer_conf",
    pattern = "**/plugins/init.lua",
    command = "source <afile> | PackerSync",
  })

  -- Autocommand for highlighting on yank.
  vim.api.nvim_create_augroup("yank_highlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight the yanked text temporarily.",
    group = "yank_highlight",
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Custom configuration to open the Alpha dashboard when there's only one last buffer open.
  local function alpha_on_bye(cmd)
    local bufs = vim.fn.getbufinfo({ buflisted = true })

    vim.cmd(cmd)

    if require("core.utils").is_available("alpha-nvim") and not bufs[2] then
      require("alpha").start(true)
    end
  end

  vim.keymap.del("n", "<leader>c")

  if require("core.utils").is_available("bufdelete.nvim") then
    vim.keymap.set("n", "<leader>c", function()
      alpha_on_bye("Bdelete!")
    end, { desc = "Close buffer" })
  else
    vim.keymap.set("n", "<leader>c", function()
      alpha_on_bye("bdelete!")
    end, { desc = "Close buffer" })
  end
end
