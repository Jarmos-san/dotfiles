-- TODO: Fix the issue since it doesn't work yet!
-- Custom "on_attach" function for customizing the behaviour of the inbuilt LSP client.

-- The list of servers of which the formatting capabilities should be disabled.
local servers = { "jsonls", "sumneko_lua", "tsserver" }

return function(client)
  if vim.tbl_contains(servers, client.name) then
    astronvim.lsp.disable_formatting(client)
  end
end
