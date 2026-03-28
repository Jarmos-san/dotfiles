function tnew --wraps='tmux new-session' --description 'alias tnew=tmux new-session'
    tmux new-session $argv
end
