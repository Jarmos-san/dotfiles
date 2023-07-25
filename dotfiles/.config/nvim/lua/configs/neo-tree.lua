-- Module for configuring the "neo-tree" plugin

local M = {}

M.init = function()
  local highlight = vim.api.nvim_set_hl
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = function(name)
    return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
  end

  vim.g.neo_tree_remove_legacy_commands = 1

  -- Autocommand to highlight the current line if the buffer is a "neo-tree" filetype
  autocmd("FileType", {
    pattern = "neo-tree,*",
    group = augroup("highlight_cursorline"),
    callback = function()
      -- FIXME: Configure the plugin to highlighting the current line for accessiblity concerns
      highlight(0, "CursorLine", { ctermfg = nil, ctermbg = "White" })
    end,
  })

  -- Check if there's only one file opened with Neovim
  if vim.fn.argc() == 1 then
    -- Assign the first file opened with Neovim to the "stat" variable
    local stat = vim.loop.fs_stat(vim.fn.argv(0))

    -- Import the "Neotree" module if the "stat" variable is a directory
    if stat and stat.type == "directory" then
      require("neo-tree")
    end
  end
end

M.options = {
  close_if_last_window = true, -- Don't leave the plugin's window open as the last window
  enable_git_status = true, -- Enable Git VCS information for the current working directory
  enable_diagnostics = true, -- Enable diagnostic feedback for all files in the working directory
  filesystem = {
    hijack_netrw_behaviour = "open_current", -- Use the plugin instead of the default "netrw" plugin
    bind_to_cwd = false,
    follow_current_file = {
      enable = true,
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = {
        ".git",
        ".null-ls_*",
        ".mypy_cache",
        ".venv",
        "__pycache__",
        ".coverage",
        ".pytest_cache",
        ".ruff_cache",
        ".task",
      },
      hide_by_name = { "__init__.py" },
    },
  },
  window = {
    width = "50", -- Hard-code the size of the window width
    position = "right",
  },
}

return M
