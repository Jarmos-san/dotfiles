function dots --wraps='tmux new-session -s dotfiles -n dotfiles -c ~/.dotfiles' --description 'alias dots=tmux new-session -c ~/.dotfiles'
    tmux new-session -s dotfiles -n dotfiles -c ~/.dotfiles $argv
end
