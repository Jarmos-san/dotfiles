#!/usr/bin/env bash

set -e
trap "cleanup" EXIT

readonly DOTFILES_DIR="$HOME/.dotfiles"

echo -e "##############################--STARTING AUTOMATIC SYSTEM SETUP NOW!!--##############################\n\n"

# Logic to identify what sort of OS is the script running on.
# This is logic will be used in the script elsewhere to configure further logic
# like whether to install certain packages or not
case "$(uname -a)" in
*Microsoft*) OS="WSL" ;;
Linux*) OS="Linux" ;;
Darwin*) OS="MacOS" ;;
*) OS="" ;;
esac

if [[ "$OS" == "WSL" ]] && [[ "$OS" == "Linux" ]] && command -v apt-get; then
  echo -e "##############################--UPDATING SYSTEM PACKAGES--##############################\n\n"
  apt-get update --yes && apt-get upgrade --yes
  echo -e "##############################--SYSTEM PACKAGE UPDATE COMPLETE--##############################\n\n"
else
  echo -e "Sytem update failed, please be sure to do so afterwards..."
fi

# TODO: Refactor the Docker setup section of the script
# Download & setup Docker for the local system
DOCKER_GPG_KEY="https://download.docker.com/linux/ubuntu/gpg"
KEYRINGS="/etc/apt/keyrings"
mkdir --parents "$KEYRINGS"
chmod 0755 "$KEYRINGS"
curl --fail --silent --show-error --location "$DOCKER_GPG_KEY" |
  gpg --dearmour -o "$KEYRINGS/docker.gpg"
# Fix some annoying ShellCheck errors. See the docs for more info: https://www.shellcheck.net/wiki/SC1091
# shellcheck source=/dev/null
echo "deb [arch='$(dpkg --print-architecture)' signed-by=$KEYRINGS/docker.gpg] https://download.docker.com/linux/ubuntu \
  '$(. /etc/os-release && echo "$VERSION_CODENAME")' stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
groupadd docker && usermod --append --groups docker "$USER" && newgrp docker

unset DOCKER_GPG_KEY
unset KEYRINGS

echo -e "##############################--SETTING UP NERD FONTS--##############################\n\n"
# Download & install some Nerd Fonts on the system
# The URL to download the font assets from
CASCADIA_CODE_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CascadiaCode.zip"
CASCADIA_CODE_ZIP_FILE='cascadia.zip'

# Command to download the zipped file containing the font assets
curl --fail --silent --show-error --location --output $CASCADIA_CODE_ZIP_FILE $CASCADIA_CODE_DOWNLOAD_URL

if test -d $CASCADIA_CODE_ZIP_FILE; then
  # Extract the contents of the downloaded zipped file
  unzip $CASCADIA_CODE_ZIP_FILE -d cascadia

  # Move the necessary font assets to the required location
  mv cascadia/*.ttf "$HOME/.fonts"
fi

unset CASCADIA_CODE_DOWNLOAD_URL
unset CASCADIA_CODE_ZIP_FILE

# Ensure the system is aware of the newly loaded fonts
fc-cache --force -verbose

# List of Flatpak GUI applications which cannot be installed through Homebrew on Linux
FLATPAK_PACKAGES=(
  'com.microsoft.Edge'
  'com.spotify.Client'
  'com.discordapp.Discord'
  'com.transmissionbt.Transmission'
  'org.wezfurlong.wezterm'
  'com.calibre_ebook.calibre'
  'com.valvesoftware.Steam'
  'org.flameshot.Flameshot'
  'com.visualstudio.code'
  'io.dbeaver.DBeaverCommunity'
)

# Loop through the aforementioned list of packages to install them only if the system is a Linux distro.
if [[ ! "$OS" == "WSL" ]] && [[ ! "$OS" == "Darwin" ]]; then
  echo -e "##############################--DOWNLOADING FLATPAK APPLICATIONS--##############################\n\n"
  for package in "${FLATPAK_PACKAGES[@]}"; do
    flatpak install flathub "$package"
  done
fi

unset FLATPAK_PACKAGES

echo -e "##############################--DOWNLOADING ZSH PLUGINS--##############################\n\n"

# List of ZSH plugins
ZSH_PLUGINS=(
  'zsh-users/zsh-syntax-highlighting'
  'zsh-users/zsh-autosuggestions'
  'zsh-users/zsh-completions'
  'le0me55i/zsh-extract'
  'ael-code/zsh-colored-man-pages'
)

# Location to store the ZSH plugins in the local directory
ZSH_PLUGINS_LOCAL_DIR=$HOME/.local/share/zsh/plugins

# Check for the existence of the local ZSH directory, if not then create it
if ! test -d ZSH_PLUGINS_LOCAL_DIR; then
  mkdir --parents "$ZSH_PLUGINS_LOCAL_DIR"
fi

# Download the listed ZSH plugins to a local directory for usage
if command -v git >/dev/null 2>&1; then
  for plugin in "${ZSH_PLUGINS[@]}"; do
    git clone "git@github.com:${plugin}" "$ZSH_PLUGINS_LOCAL_DIR"
  done
fi

unset ZSH_PLUGINS
unset ZSH_PLUGINS_LOCAL_DIR

function setup_homebrew() {
  local HOMEBREW_INSTALL_SCRIPT="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

  # Download Homebrew to the local system
  curl --fail --silent --show-error --location $HOMEBREW_INSTALL_SCRIPT </dev/null

  # Conditional to check if a Brewfile exists, then install the Homebrew packages if one exists.
  if test -f "$DOTFILES_DIR/Brewfile"; then
    echo -e "##############################--DOWNLOADING HOMEBREW PACKAGES--##############################\n\n"
    if [[ ! "$OS" == "Darwin" ]]; then
      brew bundle --file "$HOME/.dotfiles/Brewfile"
    else
      brew bundle --file "$HOME/.dotfiles/macOS.Brewfile"
    fi
  else
    echo "Homebrew could not install any packages due to a missing Brewfile"
    echo -e "Please download a Brewfile from your remote dotfiles repository & run the following command:\n"
    echo "brew bundle --file <path-to-brewfile>"
  fi

  unset HOMEBREW_INSTALL_SCRIPT
}

function setup_dotfiles() {
  # Check if the local dotfiles repository exists & if any of its contents are symlinked
  if test -d "$DOTFILES_DIR"; then
    for file in "$DOTFILES_DIR"/*; do
      if ! test -h "$file"; then
        unlink "$file"
      fi
    done
  fi

  # Create the symlinks from the dotfiles repository
  stow dotfiles
}

function setup_gh() {
  local GH_COMPLETIONS="$HOME/.local/share/zsh/plugins/zsh-completions/src/_gh"
  local GH_PLUGINS=(
    "seachicken/gh-poi"
    "yusukebe/gh-markdown-preview"
    "chelnak/gh-changelog"
    "redraw/gh-install"
    "vilmibm/gh-screensaver"
    "k1LoW/gh-grep"
    "HaywardMorihara/gh-tidy"
  )

  # NOTE: This is a temporary workaround until the following issue thread is resolved:
  # https://github.com/zsh-users/zsh-completions/issues/1005
  # Setup completions for GitHub CLI
  if ! test -f "$GH_COMPLETIONS"; then
    gh completion --shell zsh >"$GH_COMPLETIONS"
  else
    echo "GitHub CLI completions failed to generate...skipping"
  fi

  # Setup some GitHub CLI extensions (or "plugins")
  for plugin in "${GH_PLUGINS[@]}"; do
    gh extension install "$plugin"
  done

  unset GH_COMPLETIONS
  unset GH_PLUGINS
}

# TODO: Setup SSH & GPG keys with GitHub CLI.

# TODO: Download & setup Rust on the local system as well

# TODO: Refactor the script to be "safe" by using functions & local variables
function main() {
  # List of essential packages
  local ESSENTIAL_PACKAGES=(
    'git'
    'curl'
    'flatpak'
    'ca-certificates'
    'gnupg'
  )

  if [[ ! "$OS" == "Darwin" ]] && [[ ! "$OS" == "" ]] && ! command -v apt-get; then
    echo -e "Some necessary commands cannot be installed by the automation script..."
    echo -e "Please install these packages manually before invoking the automation script again..."

    for package in "${ESSENTIAL_PACKAGES[@]}"; do
      echo "$package"
    done

    exit 1
  else
    echo -e "##############################--DOWNLOADING SOME NECESSARY 3RD-PARTY TOOLS--##############################\n\n"

    for package in "${ESSENTIAL_PACKAGES[@]}"; do
      if ! command -v "$package"; then
        apt-get install "$package"
      fi
    done

  fi

  unset ESSENTIAL_PACKAGES

  echo -e "##############################--DOWNLOADING DOTFILES FROM GITHUB--##############################\n\n"

  # Check if Git is installed then download the dotfiles repository
  if ! command -v git >/dev/null 2>&1; then
    echo -e "Git not found...please its installed & available on \$PATH!"
  else
    git clone git@github.com:Jarmos-san/dotfiles "$DOTFILES_DIR"
  fi

  if ! command brew; then
    echo -e "Failed to setup Homebrew...re-rerun the script after debugging the issue"
  else
    setup_homebrew
  fi

  if ! command stow; then
    echo -e "Failed to setup the symlinks...check if Git & GNU/Stow are installed?"
  else
    setup_dotfiles
  fi

  if ! command -v gh; then
    echo -e "Failed to setup GitHub CLI...check it out manually later on"
  else
    setup_gh
  fi

  echo -e "##############################--AUTOMATED SYSTEM SETUP COMPLETE!!--##############################\n\n"
  echo -e "Please restart the system once to ensure everything works as its supposed to..."
}

function cleanup() {
  rm --recursive --force cascadia cascadia.zip
  unset DOTFILES_DIR
  unset OS
}

# TODO: Configure the script to execute only if a "--dry-run" flag isn't passed to it
main