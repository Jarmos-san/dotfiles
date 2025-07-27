return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "pyright-langserver", "--stdio" },
  root_markes = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      client:exec_cmd({
        command = "pyright.oganizeimports",
        arguments = vim.url_from_bufnr(bufnr),
      })
    end, {
      desc = "Organize Python Imports",
    })

    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", function(path)
      if client.settings then
        client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
      else
        client.config.settings =
          vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
      end
      vim.notify("workspace/didChangeConfiguration", { settings = nil })
    end, { desc = "Reconfigure Pyright with provided Python path", nargs = 1, complete = "file" })
  end,
}
