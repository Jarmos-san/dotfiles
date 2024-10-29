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

M.terminal = {
  ---@type fun(): void
  float = function()
    local buf = vim.api.nvim_create_buf(false, true) -- false: not listed, true: scratch buffer

    -- 2. Calculate new dimensions for the floating terminal
    local width = math.floor(vim.o.columns * 0.8) -- 80% of editor width
    local height = math.floor(vim.o.lines * 0.5) -- 50% of editor height
    local row = (vim.o.lines - height) / 2 -- Center vertically
    local col = (vim.o.columns - width) / 2 -- Center horizontally

    -- 3. Open the floating window with set dimensions
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })

    -- 4. Open an interactive shell in the buffer using `termopen`
    vim.fn.termopen(vim.o.shell)
  end,

  ---@type fun(): void
  vertical = function()
    -- Create a new buffer (false: not listed, true: scratch buffer)
    local buf = vim.api.nvim_create_buf(false, true)

    -- Get the current window's dimensions
    local width = math.floor(vim.o.columns * 0.5) -- Set the width for the new split (50% of the current width)
    local height = vim.api.nvim_win_get_height(0) -- Use the current window's height

    -- Calculate the position for the new window
    local row = 0 -- Start from the top of the window
    local col = vim.api.nvim_win_get_width(0) -- Place it at the right side of the current window

    -- Open the vertical split window
    vim.api.nvim_open_win(buf, true, {
      relative = "editor", -- Relative to the editor
      width = width, -- Width of the new window
      height = height, -- Height of the new window
      row = row, -- Row position (0 for top)
      col = col, -- Column position (right of the current window)
      -- style = "minimal",
    })

    -- Open an interactive shell in the buffer using `termopen`
    vim.fn.termopen(vim.o.shell)
  end,
}

return M
