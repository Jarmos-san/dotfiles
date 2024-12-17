-- Module to configure the plugin which handles the various linters used with the editor

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "InsertLeave", "BufNewFile", "LspAttach" },
  config = function()
    require("lint").linters_by_ft = {
      lua = { "selene" },
      sh = { "shellcheck" },
      python = { "ruff", "mypy" },
      ["yaml.ansible"] = { "ansible-lint" },
    }
  end,
}
