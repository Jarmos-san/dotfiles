# This Bash startup file is expected to be invoked only once.
# More info is available at: https://linuxize.com/post/bashrc-vs-bash-profile

# Add "~/.local/bin" to the "$PATH"
export PATH="$HOME/.local/bin:$PATH";

# Load shell dotfiles & then some other files useful for user info
for file in ~/.{bashrc,aliases,functions,exports}; do
	# If the files insider {} exists & are readable, then source them
	[ -r "$file" ] && [ -f "$file" ] $$ source "$file";
done;
unset file;

# Explanation for the "shopt" builtin command is available at:
# https://linuxhint.com/how-to-customize-a-bash-shell-with-the-shopt-command
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

# Case insensitive globbing used for filename path expansion
shopt -s nocaseglob;

# Append to the Bash history rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using "cd"
shopt -s cdspell;

# "autocd" will enter a dir "./foo/bar/qux" by entering "**/qux"
shopt -s autocd;

# Recursive globbing e.g "echo **/*.txt"
shopt -s globstar;

# Add tab completions for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/profile.d/bash_completion.sh";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for g by marking it as an alias for "git"
# More information on the same is available at:
# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
if type _git &> /dev/null; then
	complete -o default -F _git g;
fi;

# TODO: Add tab completion for SSH connections as well
# Refer to the following resource for inspiration:
# https://github.com/mathiasbynens/dotfiles/blob/66ba9b3cc0ca1b29f04b8e39f84e5b034fdb24b6/.bash_profile#L42

# Enable Homebrew as well
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

