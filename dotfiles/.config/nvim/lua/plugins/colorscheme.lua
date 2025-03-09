return {
  "comfysage/evergarden",
  priority = 1000,
  opts = {
    theme = {
      variant = "fall",
      accent = "green",
    },
    editor = {
      transparent_background = false,
      sign = { color = "none" },
      float = {
        color = "mantle",
        invert_border = true,
      },
      completion = {
        color = "surface0",
      },
    },
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      telescope = true,
    },
  },
}
