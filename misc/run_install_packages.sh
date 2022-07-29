#!/usr/bin/env bash

# INFO: Install the following packages if running a Debian-based OS like Ubuntu
# - build-essential
# - procps
# - curl
# - file
# - git
# TODO: See https://www.chezmoi.io/reference/templates/variables for reference
# TODO: Run the following command to install the aforementioned packages.
# apt-get install build-essential procps curl file git

# INFO: Homebrew installer script
# HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
# INFO: The following variable is required to install Homebrew non-interactively
# export NONINTERACTIVE=1

# Command to download the shell script for installing Homebrew.
# curl --fail --silent --show-error --location "$HOMEBREW_INSTALLER" | bash

# Cleanup the variable when it's no longer required
# unset NONINTERACTIVE

# TODO: Install CLI tools from Homebrew

# TODO: Install InkScape
# echo -e "Adding new repositories to download Inkscape from\n"
#
# add-apt-repository universe --yes --update
# add-apt-repository ppa:inkscape.dev/stable --yes --update
#
# echo -e "Installing InkScape...\n"
#
# apt-get install inkscape --assume-yes

# TODO: Install Kitty-Terminal
# echo -e "Downloading Kitty terminal..."
#
# # INFO: Kitty terminal installation script
# KITTY_INSTALLER="https://sw.kovidgoyal.net/kitty/installer.sh"
#
# # INFO: Download the necessary files & folders to ~/.local/share & don't launch kitty
# # after download completes.
# curl --fail --silent --show-error --location "$KITTY_INSTALLER" \
#   | bash -s -- dest="$HOME/.local/share" launch="n"
#
# echo -e "Setting up Kitty...\n"
#
# ln --symbolic "$HOME/.local/share/kitty.app/bin/kitty" "$HOME/.local/bin"
#
# cp "$HOME/.local/share/kitty.app/share/applications/kitty.desktop" \
#   "$HOME/.local/share/applications"
#
# sed -i "s|Icon=kitty|Icon=$HOME/.local/share/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
#   "$HOME/.local/share/applications/kitty*.desktop"

# INFO: Setup GPG keys for authenticating MSFT software.
# echo -e "Downloading GPG public keys for Microsoft keys...\n"
#
# # FIXME: Check the name of the GPG key downloaded through the following cURL command.
# curl --fail --silent --show-error --location "$MSFT_GPG_KEY" | gpg --dearmor > "microsoft.gpg"
#
# echo -e "Adding the public key to the local machine...\n"
#
# # FIXME: Update the GPG key name depending on what's downloaded from the MSFT servers.
# install -o root -g root -m 644 "microsoft.gpg" "/etc/apt/trusted.gpg.d"
#
# # FIXME: Update the GPG key name.
# # TODO: Use a loop to update the sources list for both VSCode & Edge browser together.
# echo -e "Updating the sources.list directory...\n"
# echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
#   > "/etc/apt/sources.list.d/vscode.list"
#
# echo -e "Installing Microsoft Visual Studio Code...\n"
# apt-get install code

# echo -e "Installing Microsoft Edge browser...\n"
# apt-get install microsoft-edge-stable
#
# echo -e "Installing Flameshot screenshot utility...\n"
# apt-get install flameshot

# INFO: Install OBS for recording screen (and perhaps Twitch streaming someday as well)
# echo -e "Installing OBS...\n"
# add-apt-repository ppa:obsproject/obs-studio
# apt-get install obs-studio
