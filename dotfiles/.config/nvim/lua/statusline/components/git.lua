---Git branch resolution for the statusline.
---
---This module resolves the current Git branch asynchronously and caches the
---result per working directory. While resolution is in progress, the rendered
---returns `nil`.
---
---@module 'statusline.git'
local M = {}

-- Cache to store the statusline components
---@type table<string, string | nil>
local cache = {}

-- The Nerd Font icon to render with the component
local branch_icon = " "

---Returns the current Git branch for the working directory.
---
---The Git branch is resolved asynchronously using `git branch --show-current`
---and cached per working directory. While the branch is being resolved,
---the function returns an empty string. Once available, the cached,
---preformatted component is returned.
---
---@return string | nil
---A formatted Git branch string (e.g., " main") or nil if the current
---working directory is not a Git repository.
M.render = function()
  -- The current directory which is used as the key for caching the the
  -- component's rendering logic
  local cwd = vim.fn.getcwd()

  -- Check if the component is cached
  local cached = cache[cwd]
  if cached ~= nil then
    return cached
  end

  -- Initialise an empty cache if it's not found already
  cache[cwd] = nil

  -- Fetch the branch name from Git
  vim.system({ "git", "branch", "--show-current" }, { text = true }, function(result)
    if result.code == 0 then
      local branch = result.stdout:gsub("%s+", "")
      if branch ~= nil then
        cache[cwd] = branch_icon .. branch
      else
        cache[cwd] = nil
      end
    else
      cache[cwd] = nil
    end

    -- Asynchronously redraw the status if the cache hit was a miss
    vim.schedule(function()
      vim.cmd("redrawstatus")
    end)
  end)

  return nil
end

return M
