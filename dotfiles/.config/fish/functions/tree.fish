function tree --wraps="eza --tree --all --icons --ignore-glob='.git|.mypy_cache|.terraform.lock.hcl|.gitkeep' --git-ignore" --description "alias tree=eza --tree --all --icons --ignore-glob='.git|.mypy_cache|.terraform.lock.hcl|.gitkeep' --git-ignore"
    eza --tree --all --icons --ignore-glob='.git|.mypy_cache|.terraform.lock.hcl|.gitkeep' --git-ignore $argv
end
