---@brief
---
---LSP server configurations for Pyright, an LSP server and static type-checker
---for Python from Microsoft. See the source code and documentation in its
---official repository here - https://github.com/microsoft/pyright.

local set_python_path = function(command)
  local path = command.args
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf(), name = "pyright" })

  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python --[[@as table]], { python = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end

    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

---@type vim.lsp.Config
return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markes = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        deprecateTypingAliases = true,
        typeCheckingMode = "strict",
        reportUnusedCallResult = true,
        reportUnreachable = true,
        reportUnnecessaryTypeIgnoreComment = true,
        reportUninitializedInstanceVariable = true,
        reportPropertyTypeMismatch = true,
        reportMissingSuperCall = true,
        reportImportCycles = true,
        reportImplicitStringConcatenation = true,
        reportImplicitOverride = true,
        reportCallInDefaultInitializer = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Create a user command to organise the import statements in a file
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      local params = {
        command = "pyright.organizeImports",
        arguments = { vim.uri_from_bufnr(bufnr) },
      }

      -- Using client.request() directly because "pyright.organizeimports" is private
      -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request("workspace/executeCommand", params, nil, bufnr)
    end, {
      desc = "Organize Python Imports",
    })

    -- Create a user command to change/update the Python interpreter path
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightSetPythonPath",
      set_python_path,
      { desc = "Reconfigure Pyright with provided Python path", nargs = 1, complete = "file" }
    )
  end,
}
