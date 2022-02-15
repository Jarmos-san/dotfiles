#!/usr/bin/env bash

$FONTS_DIR="$HOME/.local/share/fonts"

get_latest_release() {
  curl -fsSL "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

# Download & unzip the fonts
curl -fLO "https://github.com/ryanoasis/nerd-fonts/releases/download/$(get_latest_release)/FiraCode.zip"

# Extract fonts to ~/.local/share/fonts
unzip -o FiraCode.zip -d $FONTS_DIR -x "Fura*" "*.ttf" "*Windows*" "*Complete.otf" "*Retina*"

# Reinitiate fonts cache
fc-cache --force --verbose

# Check if Fira Code was installed properly or not
fc-list | grep "Fira Code"
