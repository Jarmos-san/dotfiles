local wezterm = require("wezterm")
local mux = wezterm.mux

-- Ensure the terminal is opened is in fullscreen mode right after startup
wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- This Lua module returns a table of configuration values which Wezterm reads to
-- customise the aesthetics of the terminal.
return {
  -- Reduce unnecessary padding on the window
  window_padding = { left = 1, right = 0, top = 8, bottom = 0 },

  -- Some bare basic key bindings for managing the terminal
  keys = {
    {
      -- Key binding to toggle fullscreen mode
      key = "F11",
      mods = "NONE",
      action = wezterm.action.ToggleFullScreen,
    },
  },

  -- INFO: Enable "light mode" on the desktop
  color_scheme = "Google Dark (base16)",

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

  -- Hide the tab bar if there's only one tab open
  hide_tab_bar_if_only_one_tab = true,

  -- Make the window background transparent
  window_background_opacity = 0.96,

  -- Make the cursor to blink on the terminal
  default_cursor_style = "BlinkingBlock",

  -- Set the rate at which the cursor will blink
  cursor_blink_rate = 600,

  -- Disable checking for updates every day (which is annoying af!)
  check_for_updates = false,

  -- Disable the annoying audio bell
  audible_bell = "Disabled",

  -- Disable warning about missing glyphs
  warn_about_missing_glyphs = false,
}
