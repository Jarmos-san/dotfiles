local M = {}

-- Utlity function to make autocommands easily
M.autocmd = vim.api.nvim_create_autocmd

-- Utlity function to make augroups more easily
M.augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- Utlity function to make keybind mappings easier & DRY
M.map = function(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys

  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.format = function(command)
  -- INFO: Get the current location of the cursor on the current window
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- INFO: The formatting command to invoke after the contents are saved
  vim.cmd(command)

  -- INFO: In case the formatting got rid of the line we came from
  cursor[1] = math.min(cursor[1], vim.api.nvim_buf_line_count(0))

  -- INFO: Update the current cursor location according to the caluclated values
  vim.api.nvim_win_set_cursor(0, cursor)
end

-- Setup highlight groups for Neovim easily
M.highlight = vim.api.nvim_set_hl

-- Check if the current directory is version-controlled using Git
M.is_git_repo = function()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  local output = handle:read("*a")
  handle:close()

  if output:match("true") then
    return true
  else
    return false
  end
end

-- Check if the ".git" directory exists in the current directory
M.has_git_dir = function()
  local handle = io.popen("ls -a 2>/dev/null")
  local output = handle:read("*a")
  handle:close()

  if output:match("%.git") then
    return true
  else
    return false
  end
end

--- @class TermOptions
--- @field style "minimal" | nil The style of the window. See ":h nvim_open_win()"
--- @field border string | nil The border type of the window. See ":h nvim_open_win()"

--- Create a terminal buffer
--- @param width number The width of the terminal
--- @param height number The height of the terminal
--- @param row number The number of rows for the terminal
--- @param col number The number of columns for the terminal
--- @param opts TermOptions | nil The optional parameters to configure the look of the terminal
local create_term = function(width, height, row, col, opts)
  ---@type integer
  local buf = vim.api.nvim_create_buf(false, true)

  if not opts then
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = opts.style, ---@type string | nil
      border = opts.border, ---@type string | nil
    })
  else
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
    })
  end

  -- Start the terminal shell using the value of "$SHELL"
  vim.fn.termopen(vim.o.shell)
end

M.terminal = {
  ---@type fun(): void
  float = function()
    local width = math.floor(vim.o.columns * 0.8) -- 80% of editor width
    local height = math.floor(vim.o.lines * 0.5) -- 50% of editor height
    local row = (vim.o.lines - height) / 2 -- Center vertically
    local col = (vim.o.columns - width) / 2 -- Center horizontally

    -- Create the terminal inside the floating window
    create_term(width, height, row, col, { style = "minimal", border = "rounded" })
  end,

  ---@type fun(): void
  vertical = function()
    local width = math.floor(vim.o.columns * 0.5) -- Set the width for the new split (50% of the current width)
    local height = vim.api.nvim_win_get_height(0) -- Use the current window's height
    local row = 0 -- Start from the top of the window
    local col = vim.api.nvim_win_get_width(0) -- Place it at the right side of the current window

    -- Create the terminal inside the vertical split
    create_term(width, height, row, col, {})
  end,
}

return M
