#!/usr/bin/env zsh
#
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/space/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
setopt autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install

# Enable Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# A bunch of custom aliases for easier terminal usage.
alias ll="exa --long --all --classify --icons --git --ignore-glob='.git'"
alias dcp="docker-compose"
alias loc="wc -l"
alias mkvenv="python -m venv .venv"
alias update="sudo apt-get update && sudo apt-get upgrade -y && brew update && brew upgrade && brew autoremove"
alias tree="exa --tree --all --icons --ignore-glob='.git' --git-ignore"

# Various ZSH plugins to make the Shell usage experience better
plugins=(
    'zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh'
    'zsh-autosuggestions/zsh-autosuggestions.plugin.zsh'
    'zsh-colored-man-pages/colored-man-pages.plugin.zsh'
    'zsh-extract/extract.plugin.zsh'
    'zsh-completions/zsh-completions.plugin.zsh'
)

# Loop through the list of plugins mentioned above & source them for usage
for plugin in "${plugins[@]}"; do
    source "${ZDOTDIR:-$HOME}/.local/share/zsh/plugins/${plugin}"
done

# Ensure the "plugins" array to removed from memory for safety reasons
unset plugins

# NOTE: On Kitty, the escape codes could be different.
# Move to the end of the line when pressing the "End" key
bindkey "^[[4~" end-of-line
# Move to the start of the line when pressing the "Home" key
bindkey "^[[1~" beginning-of-line
