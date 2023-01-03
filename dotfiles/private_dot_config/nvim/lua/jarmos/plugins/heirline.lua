--[[
Module for configuring the statusline plugin.
--]]

-- local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
-- local colors = require("onedark.colors")

local M = {}

function M.config()
  local heirline = require("heirline")

  local setup_colors = function()
    return {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      -- dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      -- git_del = utils.get_highlight("diffDeleted").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      -- git_change = utils.get_highlight("diffChanged").fg,
    }
  end

  local vimode = {
    init = function(self)
      self.mode = vim.fn.mode(1)

      if not self.once then
        vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:*o",
          command = "redrawstatus",
        })
        self.once = true
      end
    end,

    static = {
      mode_names = {
        n = "NORMAL",
        v = "VISUAL",
        V = "V-BLOCK",
        i = "INSERT",
        R = "REPLACE",
        c = "COMMAND",
        t = "TERMINAL",
      },

      mode_colors = {
        n = "#F65866",
        i = "#8bcd5b",
        v = "#34bfd0",
        V = "#34bfd0",
        c = "#dd9046",
        R = "#dd9046",
        t = "#f65866",
      },
    },

    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,

    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = self.mode_colors[mode], bold = true }
    end,

    update = {
      "ModeChanged",
    },
  }

  local statusline = { vimode }

  heirline.load_colors(setup_colors())
  heirline.setup(statusline)

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      local colors = setup_colors()

      utils.on_colorscheme(colors)
    end,
    group = vim.api.nvim_create_augroup("Heirline", { clear = true }),
  })
end

return M
