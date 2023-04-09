local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

-- Some bare basic key bindings for managing the terminal
config.keys = {
  {
    -- Key binding to toggle fullscreen mode
    key = "F11",
    mods = "NONE",
    action = wezterm.action.ToggleFullScreen,
  },
}

-- Set the colorscheme to something which is usable
config.color_scheme = "Ocean Dark (Gogh)"

-- Set a monospaced font for easier time when writing code
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", {
  weight = "DemiBold",
  stretch = "Normal",
  style = "Normal",
})

-- The default shell to invoke when launching the terminal
config.default_prog = { "/home/linuxbrew/.linuxbrew/bin/zsh", "-l" }

-- Make the font size of the terminal contents legible
config.font_size = 11.0

-- Ensure the terminal is opened in maximised mode right after startup
wezterm.on("gui-startup", function(cmd)
  -- local tab, pane, window = mux.spawn_window(cmd or {})
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
