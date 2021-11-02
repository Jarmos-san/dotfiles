# Add "~/.local/bin" to the "$PATH"
export PATH="$HOME/.local/bin:$PATH";

# Load shell dotfiles & then some other files useful for user info
for file in ~/.{bashrc,aliases,functions,exports}; do
	# If the files insider {} exists & are readable, then source them
	[ -r "$file" ] && [ -f "$file" ] $$ source "$file";
done;

unset file;
