#!/usr/bin/env zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
setopt autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install

# Update the default PATH
export PATH="$HOME/.local/bin:$PATH"

# Enable Starship
eval "$(starship init zsh)"

# A bunch of custom aliases for easier terminal usage.
alias ll="exa --long --all --classify --icons --git --ignore-glob='.git'"
alias dcp="docker compose"
alias loc="wc -l"
alias mkvenv="python3 -m venv .venv"
alias tree="exa --tree --all --icons --ignore-glob='.git' --git-ignore"
alias dateiso="date +%Y-%m-%dT%H:%M:%S%z"
alias top="btop --utf-force"
alias cm="cmatrix -abs -C yellow"
alias rands="openssl rand -base64 32"

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
  bindkey "^[[4~" end-of-line
  bindkey "^[[1~" beginning-of-line
else
  bindkey "^[[H" beginning-of-line
  bindkey "^[[F" end-of-line
  bindkey "^[[3~" delete-char
fi
