eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish

if status is-interactive
    starship init fish | source
end
