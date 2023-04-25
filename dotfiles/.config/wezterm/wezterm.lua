local wezterm = require("wezterm")
local mux = wezterm.mux

-- Ensure the terminal is opened in maximised mode right after startup
wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- This Lua module returns a table of configuration values which Wezterm reads to
-- customise the aesthetics of the terminal.
return {
  -- Reduce unnecessary padding on the window
  window_padding = { left = 1, right = 0, top = 1, bottom = -4 },

  -- Some bare basic key bindings for managing the terminal
  keys = {
    {
      -- Key binding to toggle fullscreen mode
      key = "F11",
      mods = "NONE",
      action = wezterm.action.ToggleFullScreen,
    },
  },

  -- Set the colorscheme to something which is usable
  color_scheme = "Catppuccin Mocha",

  -- Set a monospaced font for easier time when writing code
  font = wezterm.font("CaskaydiaCove Nerd Font Mono", {
    weight = "DemiBold",
    stretch = "Normal",
    style = "Normal",
  }),

  -- The default shell to invoke when launching the terminal
  default_prog = { "/home/linuxbrew/.linuxbrew/bin/zsh", "-l" },

  -- Make the font size of the terminal contents legible
  font_size = 11.0,
}
