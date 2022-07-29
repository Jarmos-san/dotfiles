#!/usr/bin/env bash

FONTS_DIR="$HOME/.local/share/fonts"

get_latest_release() {
  curl --silent "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
    | grep '"tag_name":' \
    | sed -E 's/.*"([^"]+)".*/\1/'
}

# Download the zipped file off of the latest GitHub release assets.
FIRACODE_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$(get_latest_release)/FiraCode.zip"
curl --fail --location --remote-name "$FIRACODE_DOWNLOAD_URL"

# Extract fonts to ~/.local/share/fonts
unzip -o FiraCode.zip -d "$FONTS_DIR" -x "Fura*" "*.ttf" "*Windows*" "*Complete.otf" "*Retina*"

rm --force "FiraCode.zip"

# Reinitiate the fonts cache.
fc-cache --force --verbose

# Check if Fira Code was installed properly or not
fc-list | grep "Fira Code"
