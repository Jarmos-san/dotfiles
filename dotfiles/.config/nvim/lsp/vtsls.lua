---@brief
---
---Configuration module for the `vtsls` Language Server Protocol (LSP) server.
---
---`vtsls` provides TypeScript and JavaScript language intelligence via `tsserver`
---with optional Vue plugin integration.
---
---The module returns a `vim.lsp.Config` table consumable using Neovim's builtin LSP
---setup mechanism
---
---Module containing the configurations for the `vtsls` LSP server for TypeScript and
---JavaScript support. More details about setting up the tools are documented here:
---https://github.com/vuejs/language-tools/discussions/5456

---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
  init_options = { hostInfo = "neovim" },
  root_dir = function(bufnr, on_dir)
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    root_markers = vim.fn.has("nvim-0.11.6") == 1 and { root_markers, { ".git" } }
      or vim.list_extend(root_markers, { ".git" })

    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand("~/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin"),
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
  on_attach = function(client)
    local capabilities = client.server_capabilities

    if capabilities == nil then
      return
    end

    if vim.bo.filetype == "vue" then
      capabilities.semanticTokensProvider.full = false
    else
      capabilities.semanticTokensProvider.full = true
    end
  end,
}
