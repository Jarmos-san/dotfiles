---Cursor position progress indicator
---
---@module 'statusline.cursor'
local M = {}

---Returns a visual indicator representing the cursor's vertical position
---within the current buffer.
---
---The function computes the cursor's progress as a normalized ratio (current
---line / total lines) and maps it to a glyph chosen from a predefined sequence
---of Nerd Font block characters. The resulting glyph provides a compact,
---intuitive progress indicator suitable for use in a statusline.
---
---@return string | nil
---A formatted statusline segment containing the current cursor location.
M.render = function()
  -- Total number of lines in the buffer
  local total_lines = vim.fn.line("$")

  -- No meaningful cursor context
  if total_lines == 0 then
    return nil
  end

  -- Current cursor position
  local line = vim.fn.line(".")

  -- Normalised progress (0.0 -> 1.0)
  local progress = line / total_lines

  -- Nerd Font progress blocks (low -> high)
  local blocks = { " ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }

  -- Map progress to a block index
  local index = math.ceil(progress * #blocks)
  index = math.max(1, math.min(index, #blocks))

  -- Set the highlights for the segment
  local hl = vim.api.nvim_set_hl
  local colors = require("statusline.colors").COLORS
  local bg = colors.bg.bg0_h
  hl(0, "StatuslineCursor", { fg = colors.fg.fg2, bg = bg })
  hl(0, "StatuslineCursorGlyph", { fg = colors.bright.orange, bg = bg })

  return string.format("%%= %%#StatuslineCursor# L: %%l | C: %%c %%#StatuslineCursorGlyph#%s", blocks[index])
end

return M
