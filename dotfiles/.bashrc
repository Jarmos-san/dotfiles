#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Enable "bookmarks" for quick access to certain folders in the system
shopt -s cdable_vars

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case insenstive globbing used for filename path expansion
shopt -s nocaseglob

# Autocorrect typos in path names when using "cd"
shopt -s cdspell 2>/dev/null

# Correct speiing errors during tab-completion
shopt -s dirspell 2>/dev/null

# Following settings enables Bash to enter a dir, say "~/.config/kitty"
# by simply typing "**/kitty"
shopt -s autocd 2>/dev/null

# Recursive globbing e.g. "echo **/*.etc"
shopt -s globstar 2>/dev/null

# Save multi-line commands as one command
shopt -s cmdhist

# Perform file completion in a case insensitive manner
bind "set completion-ignore-case on"

# Treat hyphens & underscores as equivalents
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a `/` when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Enable Bash Completion for CLI tools installed with Homebrew
if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        # shellcheck source=/dev/null
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        # shellcheck disable=SC2066
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/*"; do
            # shellcheck source=/dev/null
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
fi

# Enable Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Enable Starship for custom prompt experience
eval "$(starship init bash)"

# BEGIN_KITTY_SHELL_INTEGRATION
# shellcheck source=/dev/null
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
# END_KITTY_SHELL_INTEGRATION

# Necessary configurations for GPG to work properly
GPG_TTY=$(tty)
export GPG_TTY
gpgconf --launch gpg-agent

# Append PATH with additional directories which will might or mightn't
# contain binaries to be invoked from the CLI.
PATH=$PATH:$HOME/.local/bin

# This is required for starship to recognise the location of its config file.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# A bunch of custom aliases for easier terminal usage.
alias ll="exa --long --all --classify --icons --git --ignore-glob='.git'"
alias dcp="docker-compose"
alias loc="wc -l"
alias mkvenv="python -m venv .venv"
alias update="sudo apt-get update && sudo apt-get upgrade -y && brew update && brew upgrade && brew autoremove"
alias mx="tmux -u"
. "$HOME/.cargo/env"
