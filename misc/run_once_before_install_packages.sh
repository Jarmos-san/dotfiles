#!/usr/bin/env bash

# GUI applications to install to the system are:
#   1. Visual Studio Code
#   2. Inkscape
#   3. Kitty terminal emulator
#   4. Microsoft Edge Browser
#   5. Persepolis Download Manager

# Repositories to add to install the aforementioned applications from:
# 1. "universe"
# 2. "ppa:inkscape.dev/stable"
# 3. "ppa:persepolis/ppa"

echo -n "Downloading GPG keys from Microsoft's servers to sign the DEB packages..."

echo -n "Adding a couple of third-party repositories to download some applications from..."

echo -n "Updating the APT sources to download Microsoft's Edge Browser & Visual Studio Code..."

echo -n "Installing the GUI applications..."
apt-get --assume-yes install code microsoft-edge-stable persepolis inkscape

echo -n "Installing the Kitty terminal emulator..."

KITTY_INSTALLER_SCRIPT="https://sw.kovidgoyal.net/kitty/installer.sh"

curl --silent --fail --show-error --location "$KITTY_INSTALLER_SCRIPT" \
  | bash -s -- dest="$HOME/.local/share" launch="n"

echo -n "Setting up the Kitty Terminal"

ln --symbolic "$HOME/.local/share/kitty.app/bin/kitty" "$HOME/.local/bin"

cp "$HOME/.local/share/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications"

sed -i "s|Icon=kitty|Icon=$HOME/.local/share/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty*.desktop"

echo -n "Installing Node.js..."

KEYRING=/usr/share/keyrings/nodesource.gpg
VERSION=node_18.x
DISTRO="$(lsb_release --short --codename)"
curl --silent --fail --show-error --location https://deb.nodesource.com/gpgkey/nodesource.gpg.key \
  | gpg --dearmor \
  | tee "$KEYRING" >/dev/null

gpg --no-default-keyring --keyring "$KEYRING" --list-keys
echo "deb [signed-by=$KEYRING] https://deb.nodesource.com/$VERSION $DISTRO main" \
  | tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src [signed-by=$KEYRING] https://deb.nodesource.com/$VERSION $DISTRO main" \
  | tee -a /etc/apt/sources.list.d/nodesource.list

apt-get install nodejs
