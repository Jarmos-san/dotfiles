-- Module for configuring the Treesitter plugin

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function()
      require("nvim-treesitter").update():wait(300000)
    end,
    config = function()
      local parsers = {
        "astro",
        "bash",
        "caddy",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "editorconfig",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "hcl",
        "html",
        "ini",
        "javascript",
        "jinja",
        "jinja_inline",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "lua_patterns",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "regex",
        "robots",
        "rst",
        "scss",
        "terraform",
        "tsx",
        "toml",
        "typescript",
        "typst",
        "yaml",
        "vim",
        "vimdoc",
        "vue",
      }
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(parsers):wait(300000)
    end,
  },
}
