--[
-- =================================================================================
-- This is the main initialisation file which Neovim invokes during startup.
-- All the other modular Lua files available under the "~/.config/nvim/lua"
-- directory are imported in to this single initialisation file.
-- =================================================================================
--]

-- A simple wrapper function around the inbuilt "pcall" function. It ensure the other
-- user-defined modules are invoked safely in case one of them contains a syntax error
-- or something similar.
local protected_call = function(module_name)
  local ok, status = pcall(require, module_name)

  if not ok then
    print(module_name .. " not loaded because: " .. status)
  end
end

protected_call("jarmos.settings")
protected_call("jarmos.keymaps")
protected_call("jarmos.plugins")
