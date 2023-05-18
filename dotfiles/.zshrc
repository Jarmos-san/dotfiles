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

# A bunch of custom aliases for easier terminal usage.
alias ll="exa --long --all --classify --icons --git --ignore-glob='.git'"
alias dcp="docker-compose"
alias loc="wc -l"
alias mkvenv="python -m venv .venv"
alias tree="exa --tree --all --icons --ignore-glob='.git' --git-ignore"
alias dateiso="date +%Y-%m-%dT%H:%M:%S%z"
alias top="btop --utf-force"

# Various ZSH plugins to make the Shell usage experience better
plugins=(
    'zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh'
    'zsh-autosuggestions/zsh-autosuggestions.plugin.zsh'
    'zsh-colored-man-pages/colored-man-pages.plugin.zsh'
    'zsh-extract/extract.plugin.zsh'
    'zsh-completions/zsh-completions.plugin.zsh'
)

# Load the Catppuccin colour scheme for ZSH
source "${ZDOTDIR:-$HOME}/.local/share/zsh/plugins/zsh-syntax-highlighting/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# Loop through the list of plugins mentioned above & source them for usage
for plugin in "${plugins[@]}"; do
    source "${ZDOTDIR:-$HOME}/.local/share/zsh/plugins/${plugin}"
done

# Ensure the "plugins" array to removed from memory for safety reasons
unset plugins

# Configure some ZSH keybinds only if using the Kitty terminal
if [[ $TERM == "kitty-xterm" ]]; then
    # Move to the end of the line when pressing the "End" key
    bindkey "^[[4~" end-of-line

    # Move to the start of the line when pressing the "Home" key
    bindkey "^[[1~" beginning-of-line
fi

#############################################################################
# Update the local machine using the native system package manager (could be
# "apt-get" for Debian based distros or "pacman/yay" for Arch Linux based
# distros)
#
# Arguments:
#   None
#
# Outputs:
#   None
#############################################################################
function update() {
    if [[ -f "/etc/os-release" ]]; then
        source "/etc/os-release"
        if [[ $ID == "ubuntu" ]] && command -v brew >/dev/null 2>&1; then
            # Invoke the appropriate package manager to update the list of
            # packages
            sudo apt-get update &&
                sudo apt-get upgrade --assume-yes &&
                brew update &&
                brew upgrade &&
                brew autoremove
        elif [[ $ID == "arch" ]]; then
            # Invoke "pacman" to sync the system package list & update the
            # packages
            sudo pacman --sync --sysupgrade --refresh --noconfirm
            if command -v yay >/dev/null 2>&1; then
                # Invoke the "yay" to update the list of packages available
                # through the AUR.
                yay --sync --sysupgrade --refresh --noconfirm
            else
                echo "yay not found. Skipping AUR updates."
            fi
        else
            echo "Unsupported distribution: $ID"
            return 1
        fi
    else
        echo "Unable to determine the Linux distribution."
        return 1
    fi
}
