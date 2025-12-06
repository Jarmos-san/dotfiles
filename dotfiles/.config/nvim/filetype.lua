-- Module for defining new filetypes. I picked up these configurations based on inspirations from this dotfiles repo:
-- https://github.com/davidosomething/dotfiles/blob/be22db1fc97d49516f52cef5c2306528e0bf6028/nvim/lua/dko/filetypes.lua

vim.filetype.add({
  -- Detect and assign filetype based on the extension of the filename
  extension = {
    astro = "astro",
    mdx = "markdown",
    log = "log",
    conf = "conf",
    env = "dotenv",
  },
  -- Detect and apply filetypes based on the entire filename
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
    ["cloudbeaver.conf"] = "jsonc",
    ["playbook.yml"] = "yaml.ansible",
    ["site.yml"] = "yaml.ansible",
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
    [".*/ansible/.*%.ya?ml"] = "yaml.ansible", -- Match all YAML files under the "ansible" directory
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
    [".*/ansible/.*%.ya?ml%.j2"] = "yaml", -- Ansible template should be considered YAML files
    [".*/*.conf*"] = "conf", -- Config files (like "postgresql.conf" and so on)
    [".*/Caddyfile%.?.*"] = "caddy", -- Match files like "Caddyfile", "Caddyfile.j2", "Caddyfile.tmpl"
  },
})
