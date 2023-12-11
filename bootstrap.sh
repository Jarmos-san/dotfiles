#!/usr/bin/env bash

###############################################################################
# Script to automatically setup a fresh new Linux/MacOS system (or VM).
#
# This script should ONLY be used after installing a fresh new OS on a new
# machine or inside a VM to setup a development environment automatically. The
# script will install necessary tools like code editors, package managers and
# more before setting up their configuration files automatically.
#
# USAGE: To use the script, run the following command (its not ready for usage yet);
#
# curl -fsSL https://raw.githubusercontent.com/<username>/<repository>/path/to/script \
#   | bash -s
#
# NOTE: The script is designed to be subjective, hence it is RECOMMENDED to NOT
# invoke it without understanding the context of the contents! Please read
# through the script or reach out to the author for clarification on what
# certain parts of the script does.
#
# DISCLAIMER: The script IS NOT TESTED and there is no guranteed it works
# properly!
#
# Author: Somraj Saha <somraj.saha@jarmos.dev>
# License: MIT (see the LICENSE document for more info on this regards)
###############################################################################

# Enable some options for Bash to stop executing the script if there's an error
set -o errexit
set -o nounset
set -o pipefail

# Enable debugging capabilities to the script
if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

# Logic to print out a simple help message to STDOUT
if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
  echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
  exit
fi

# Execute the script in context to the current directory where the script is run
cd "$(dirname "$0")"

###############################################################################
# Print a nicely formatted informative message to STDOUT
###############################################################################
info() {
  echo -e "\033[0;34m[INFO]\033[0m $1"
}

###############################################################################
# Print a nicely formatted warning message to STDOUT
###############################################################################
warn() {
  echo -e "\033[0;33m[WARN]\033[0m $1"
}

###############################################################################
# Print a nicely formatted success message to STDOUT
###############################################################################
success() {
  echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

###############################################################################
# Print a nicely formatted error message to STDOUT
###############################################################################
error() {
  echo -e "\033[0;31m[ERROR]\033[0m $1"
}

###############################################################################
# Warn user and prompt for confirmation before executing the script
###############################################################################
warn_user() {
  warn "The script will perform an automated setup of the system and can cause\
  potential harm to the system!"

  read -rp "Do you still want to proceed? (yes/no) " yn

  case $yn in
    yes) info "This system will now be automatically setup..." ;;
    no)
      info "Aborting automated system updated..."
      exit 0
      ;;
    *)
      error "Invalid response"
      exit 1
      ;;
  esac
}

# Warn and prompt the user for confirmation to prevent accidental execution
warn_user

info "Please manually enter the prompts below before the automation starts"

GHTOKEN=$(read -rp "GitHub Access Token: ")
SSH_KEY_NAME=$(read -rp "SSH key name for GitHub: ")
# GPG_SIGN_NAME=$(read -rp "GPG signature name: ")
# GPG_SIGN_EMAIL=$(read -rp "GPG signature email address: ")
# GPG_SIGN_KEY=$(read -rp "GPG signature key: ")
OS_NAME=$(grep -Po "(?<=^ID=).+" /etc/os-release | sed 's/"//g')

info "Automatic setup is starting...please feel free to grab a cup of coffee!"

################################################################################
# On Debian systems, update the sources to point to the "unstable" repository
################################################################################
add_unstable_sources() {
  unstable_repo_url="deb https://deb.debian.org/debian unstable main"
  sources_list="/etc/apt/sources.list"
  echo "$unstable_repo_url" | tee "$sources_list" &>/dev/null
}

###############################################################################
# Update the system before starting the automated setup
###############################################################################
update_system() {
  info "Updating the system before starting the automated setup..."

  case "$OS_NAME" in
    debian)
      add_unstable_sources
      apt-get update
      apt-get upgrade --yes
      ;;
    ubuntu)
      apt-get update
      apt-get upgrade --yes
      ;;
    *)
      error "Failed to identify the OS"
      exit 1
      ;;
  esac
}

###############################################################################
# Install some necessary prerequisite tools before the setup script runs
###############################################################################
install_prerequisite_tools() {
  # List of prerequisite tools to check for existence
  declare -a prerequisite_tools

  # List of prerequisite tools which aren't installed and will be eventually!
  declare -a missing_tools

  case "$OS_NAME" in
    debian | ubuntu)
      prerequisite_tools=(
        "git" "curl" "build-essential" "gnupg" "ca-certificates"
      )
      ;;
    *)
      error "Failed to identify the OS!"
      exit 1
      ;;
  esac

  # Check for missing prerequisite tools and store them for future reference
  for tool in "${prerequisite_tools[@]}"; do
    if ! command -v "${tool}" &>/dev/null; then
      missing_tools+=("$tool")
    else
      missing_tools=()
    fi
  done

  if [[ ${#missing_tools[@]} -ne 0 ]]; then
    warn "These tools were not found & hence will be installed!"

    for tool in "${missing_tools[@]}"; do
      echo "    $tool"
    done

    apt-get install --yes --no-install-recommends "${missing_tools[@]}"

    info "Prerequisite tools installed...proceeding with automated setup"
  fi
}

###############################################################################
# Setup necessary directories relative to the home directory on the system
###############################################################################
create_necessary_dirs() {
  declare -a dirs

  dirs=(".config" ".gnupg" ".ssh" "projects" "work")

  info "Setting up necessary directories for proper system functioning"

  for dir in "${dirs[@]}"; do
    if [[ ! -d "$HOME/$dir" ]]; then
      info "$HOME/$dir not found...created"
      mkdir --parents "$HOME/$dir"
    fi
  done
}

###############################################################################
# Setup SSH for authenticating to GitHub using Git
###############################################################################
setup_github_ssh() {
  # Check for the "~/.ssh" directory's existence to createh the SSH keys safely
  if [[ ! -d "$HOME/.ssh" ]]; then
    error "The $HOME/.ssh directory does not exist...please create it!"
    exit 1
  fi

  info "Generating the SSH secret/public key pair now..."

  ssh-keygen -q -b 4096 -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519"

  pubkey=$(cat "$HOME/.ssh/id_ed25519.pub")

  curl --silent --location \
    --request POST \
    --header "Accept: application/vnd.github+json" \
    --header "Authorization: Bearer $GHTOKEN" \
    --header "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/user/keys \
    --data-binary "{\"title\":\"$SSH_KEY_NAME\",\"key\":\"$pubkey\"}"

  info "SSH public key pushed to remote service..."

  eval "$(ssh-agent -s)"
  ssh-add "$HOME/.ssh/id_ed25519.pub"

  info "Testing SSH connection to GitHub..."
  ssh -T git@github.com
}

###############################################################################
# Setup and install fonts
###############################################################################
setup_fonts() {
  # URL for Cascadia Code assets to download from
  font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip"

  # Only download and setup the Cascadia Code fonts for systems other than WSL2
  if [[ ! -e "/proc/sys/fs/binfmt_misc/WSLInterop" ]]; then
    info "Downloading fonts from the remote source..."

    curl --silent --fail --show-error --remote-name "$font_url"

    unzip CascadiaCode.zip &>/dev/null

    rm CascadiaCode.zip

    mv ./CascadiaCode/CaskaydiaCoveNerdFontMono-Bold.ttf "$HOME/.fonts"
  fi
}

###############################################################################
# Setup and install the "lazy.nvim" package manager for Neovim on the system
###############################################################################
install_lazy_nvim() {
  lazy_nvim_repo="git@github.com:folke/lazy.nvim"
  lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"

  info "Preparing to setup up the LazyNvim package manager for Neovim..."

  # If the LazyNvim installation directory doesn't exist, create it
  if [[ ! -d "$lazy_path" ]]; then
    mkdir --parents "$lazy_path"
  fi

  # Exit script execution safely if Git isn't installed and/or accessible
  if ! command -v gits &>/dev/null; then
    error "Failed to installed LazyNvim...please ensure Git is installed!"
    exit 1
  fi

  # Clone the LazyNvim source repository to the local machine for usage
  git clone --filter=blob:none $lazy_nvim_repo --branch=stable "$lazy_path" \
    &>/dev/null

  success "LazyNvim installation complete!"
}

###############################################################################
# Install some ZSH plugns
###############################################################################
install_zsh_plugins() {
  declare -a plugins

  # The list of plugins to install
  plugins=(
    "zsh-users/zsh-syntax-highlighting"
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-completions"
    "le0me55i/zsh-extract"
    "ael-code/zsh-colored-man-pages"
  )

  # The directory to install the plugins to
  plugins_directory="$HOME/.zsh/plugins"

  info "Preparing to install ZSH plugins..."

  # If the plugins directory doesn't exist create one
  if [[ ! -d "$plugins_directory" ]]; then
    mkdir --parents "$plugins_directory"
  fi

  # Ensure Git is installed & executable, else exit the script execution safely
  if [[ ! $(command -v git &>/dev/null) ]]; then
    error "Git not found...please ensure its installed and executable!"
    exit 1
  fi

  info "Downloading ZSH plugins to $plugins_directory"

  # Download the remote plugin repositories to the local plugins directory
  for plugin in "${plugins[@]}"; do
    git clone "git@github.com:$plugin" "$plugins_directory"
  done

  success "ZSH plugins installed!"

  info "The plugins will be usable after a system restart..."
}

###############################################################################
# Setup the dotfiles and related configuration files
# TODO: Ensure this block of logic work as expected
###############################################################################
setup_dotfiles() {
  info "Preparing to download and setup the dotfiles..."

  # Create the directory if it doesn't already exists
  if [[ ! -d "$HOME"/.dotfiles ]]; then
    mkdir --parents "$HOME"/.dotfiles
  fi

  # Check if git is installed & executable else exit safely
  if ! command -v git &>/dev/null; then
    error "Git not found...please ensure its installed and executable!"
    exit 1
  fi

  git clone git@github.com:Jarmos-san/dotfiles "$HOME"/.dotfiles

  # Create symlinks of the dotfiles
  for file in "$HOME"/.dotfiles/dotfiles/*; do
    if [[ -f "$file" || -d "$file" ]]; then
      ln --symbolic "$file" "$HOME"
      info "Created symlink for $file"
    fi
  done

  success "Dotfiles setup complete!"
}

###############################################################################
# The entrypoint of the script which will run the script as per the prescribed
# logic
###############################################################################
main() {
  # TODO: Uncomment the function blog when its ready for usage

  # Perform a preliminary system update before starting the automated setup
  # update_system

  # Ensure certain folders are present and/or created for a smooth operation
  # create_necessary_dirs

  # Setup SSH for Git/GitHub for cloning/managing the dotfiles itself
  # setup_github_ssh

  echo "Setting up system automatically!"

  # setup_fonts

  # Install prerequisite tools before the automated setup
  # install_prerequisite_tools

  # Install and setup the "lazy.nvim" package manager for Neovim
  # install_lazy_nvim

  # install_zsh_plugins

  # setup_dotfiles
}

# Check whether script has sudo privleges, if so then execute else exit the flow
if [[ ! $EUID -gt 0 ]]; then
  error "Ensure the script executes with \"sudo\" privileges"
  exit 1
else
  # Defer running the script till the last moment for safety reasons
  main "$@"
fi
