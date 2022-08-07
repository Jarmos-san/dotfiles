return {
  opt = {
    relativenumber = true,
    hlsearch = false,
    ignorecase = true,
    smartcase = true,
  },
  -- Vim options local only to a Window.
  wo = {
    list = true,
  },
  -- Vim options which are global.
  g = {
    mapleader = " ",
    listchars = {
      eol = "↴",
      tab = "→ ",
      space = "·",
      kextends = "…",
      precedes = "…",
      trail = ".",
    },
  },
}
