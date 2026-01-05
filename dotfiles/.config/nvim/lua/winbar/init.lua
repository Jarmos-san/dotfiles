local M = {}

local setup_highlights = function()
  local highlights = {
    Winbar = { bg = "#3c3836" },
    WinbarFilepath = { fg = "#fabd2f" },
    WinbarModifiedGlyph = { fg = "#fe8019" },
  }

  for name, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, spec)
  end
end

local create_filepath = function()
  local filepath = vim.api.nvim_eval_statusline("%f", {}).str
  local styled_filepath = string.gsub(filepath, "/", "  ")

  return styled_filepath
end

M.render = function()
  local segments = {}

  -- local filepath = "%#WinbarFilepath# %f %*"
  local filepath = "%#WinbarFilepath#" .. " " .. create_filepath() .. " "

  local modified
  if vim.bo.modified then
    modified = "%#WinbarModifiedGlyph# %#Winbar#"
  end

  table.insert(segments, filepath)
  table.insert(segments, modified)

  local winbar = table.concat(segments)

  local disabled_filetypes = { ministarter = true, lazy = true, mason = true, ["TelescopePrompt"] = true }
  if not disabled_filetypes[vim.bo.filetype] then
    return winbar
  else
    return "%#Normal#"
  end
end

M.setup = function()
  setup_highlights()

  vim.o.winbar = "%!v:lua.require('winbar').render()"
end

return M
