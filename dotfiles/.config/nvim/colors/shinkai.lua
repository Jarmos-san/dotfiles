-- My personalised colorscheme based on certain inspirations from the Makoto Shinkai movie styles

local highlight = vim.api.nvim_set_hl

-- Highlights for the current cursor line and the number column
highlight(0, "CursorLineNr", { bg = nil, fg = "#D4D4D4" })
highlight(0, "CursorLine", { bg = nil })
highlight(0, "LineNr", { fg = "grey" })

-- INFO: Provide highlights to the complettion menu items similar to that of VSCode
highlight(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
highlight(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
highlight(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
highlight(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
highlight(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
highlight(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
highlight(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
highlight(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
highlight(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
highlight(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
highlight(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
