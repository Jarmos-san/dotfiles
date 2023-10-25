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

# Check if ~/.zsh directory exists
if [[ -d "$HOME/.zsh" ]]; then
  # Source all files within the ~/.zsh directory
  for file in "$HOME/.zsh"/*; do
    source "$file"
  done
fi

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

# INFO: See the thread here - "https://vi.stackexchange.com/a/7654" for more information
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
