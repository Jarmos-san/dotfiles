# An abbreviation for listing the contents of the current directory using "eza"
abbr --add ll "eza --long --all --classify --icons --git --ignore-glob='.git|.mypy_cache|.venv'"

# Print the directory tree of the contents of a directory
abbr --add tree "eza --tree --all --icons --ignore-glob='.git|.mypy_cache|.terraform.lock.hcl|.gitkeep' --git-ignore"

# Print the lines of code of a file
abbr --add loc "wc --lines"
