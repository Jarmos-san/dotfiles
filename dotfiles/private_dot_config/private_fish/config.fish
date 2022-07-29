eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if status is-interactive
    starship init fish | source
end
