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

# FIXME: Doesn't work for now. Take a look at the following Stack Exchange thread for further instructions
# https://unix.stackexchange.com/a/33898
if [[ -f "$HOME/.zsh/functions" ]]; then
  source "$HOME/.zsh/functions"
fi

# Update the default PATH
export PATH="$HOME/.local/bin:$PATH"

# Enable Starship
eval "$(starship init zsh)"

# A bunch of custom aliases for easier terminal usage.
alias ll="exa --long --all --classify --icons --git --ignore-glob='.git'"
alias dcp="docker-compose"
alias loc="wc -l"
alias mkvenv="python3 -m venv .venv"
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
      sudo apt-get update \
        && sudo apt-get upgrade --assume-yes \
        && brew update \
        && brew upgrade \
        && brew autoremove
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

#############################################################################
# Create a base template Markdown file for blogging.
#
# Arguments:
#   The filename for the Markdown file
#
# Outputs:
#   None
#############################################################################
# function mkblog() {
#   # Store the name of the Markdown file to write the blog in to
#   local filename="${1}.md"
#
#   # Check if the Markdown file already exists
#   if [[ -e "$HOME/Projects/jarmos.dev/_blog/$filename.md" ]]; then
#     echo "File $filename already exists..."
#     return 1
#   fi
#
#   # The template contents of the Markdown file
#   local template=$(
#     cat <<EOF
# ---
# title: The Title of the Blog Post
# date: $(date +%Y-%m-%d)
# slug: $1
# description: |
#   The SEO optimised description of the blog post.
# coverImage:
#   url: https://picsum.photos/200/300
#   alt: The tagline of the image used in the OG Graph showcase and more.
# summary: |
#   A brief summary of the article (use ChatGPT to create a proper summary of
#   the article).
# ---
#
# # The Title of the Blog Post
#
# ![The alt message of the cover image](https://picsum.photos/200/300)
#
# Some content for the blog post...
# EOF
#   )
#
#   # Ensure the Markdown files are created only in the local blog repository
#   # to prevent unnecessary Markdown file generation.
#   if [[ "$(pwd)" != "$HOME/Projects/jarmos.dev" ]]; then
#     echo "ERROR: Not the ideal location to create a blog post..."
#     return 1
#   else
#     echo "$template" >"$HOME/Projects/jarmos.dev/_blog/$filename"
#     echo "Markdown file $filename successfully created!"
#   fi
# }
