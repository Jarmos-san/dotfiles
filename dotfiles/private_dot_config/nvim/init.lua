--[
-- =================================================================================
-- This is the main initialisation file which Neovim invokes during startup.
-- All the other modular Lua files available under the "~/.config/nvim/lua"
-- directory are imported in to this single initialisation file.
-- =================================================================================
--]

-- List of files located at "~/.config/nvim/lua/jarmos"
local files = { "settings", "keymaps", "plugins" }

-- Iterate through the list of files inside "~/.config/nvim/lua/jarmos" & load them.
for _, file in ipairs(files) do
  local module_name = "jarmos" .. "." .. file
  local ok, status = pcall(require, module_name)

  if not ok then
    print(module_name .. " not loaded because: " .. status)
  end
end
