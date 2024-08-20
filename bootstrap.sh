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

read -rp "GitHub Access Token: " github_pat
read -rp "SSH key name for GitHub: " github_ssh_key_name
read -rp "Enter email address for Git: " git_email
read -rp "Enter username for Git: " git_name

GHTOKEN="$github_pat"
SSH_KEY_NAME="$github_ssh_key_name"
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
  echo "$unstable_repo_url" | tee "$sources_list" &> /dev/null
}

###############################################################################
# Update the system before starting the automated setup
###############################################################################
update_system() {
  info "Updating the system before starting the automated setup..."

  case "$OS_NAME" in
    debian)
      add_unstable_sources
      sudo apt-get update
      sudo apt-get upgrade --yes
      ;;
    ubuntu)
      sudo apt-get update
      sudo apt-get upgrade --yes
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
    if ! command -v "${tool}" &> /dev/null; then
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

    sudo apt-get install --yes --no-install-recommends "${missing_tools[@]}"

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
#
# FIXME: Identify better ways to automate SSH setup for GitHub because it fails
# and breaks right now
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

  chmod 600 "$HOME/.ssh/*"
  chmod 700 "$HOME/.ssh"
  chmod 644 "$HOME/.ssh/*.pub"

  eval "$(ssh-agent -s)" &>2 /dev/null

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

    unzip CascadiaCode.zip &> /dev/null

    rm CascadiaCode.zip

    mv ./CascadiaCode/CaskaydiaCoveNerdFontMono-Bold.ttf "$HOME/.fonts"
  fi
}

###############################################################################
# Setup and install the "lazy.nvim" package manager for Neovim on the system
###############################################################################
install_lazy_nvim() {
  lazy_nvim_repo="https://github.com/folke/lazy.nvim"
  lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"

  info "Preparing to setup up the LazyNvim package manager for Neovim..."

  # If the LazyNvim installation directory doesn't exist, create it
  if [[ ! -d "$lazy_path" ]]; then
    mkdir --parents "$lazy_path"
  fi

  # Exit script execution safely if Git isn't installed and/or accessible
  if ! command -v git &> /dev/null; then
    error "Failed to installed LazyNvim...please ensure Git is installed!"
    exit 1
  fi

  # Clone the LazyNvim source repository to the local machine for usage
  git clone --filter=blob:none $lazy_nvim_repo --branch=stable "$lazy_path" \
    &> /dev/null

  success "LazyNvim installation complete!"
}

###############################################################################
# Install some ZSH plugns
###############################################################################
install_zsh_plugins() {
  declare -a plugins

  # Location where the ZSH plugins will be downloaded to
  plugins_parent_directory="$HOME/.zsh/plugins"

  # List of all the ZSH plugins
  plugins=(
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "https://github.com/zsh-users/zsh-completions.git"
    "https://github.com/ael-code/zsh-colored-man-pages.git"
  )

  info "Preparing to install the ZSH plugins..."

  # Create the parent ZSH plugins directory if it doesn't already exist
  if [[ ! -d $plugins_parent_directory ]]; then
    mkdir --parents "$plugins_parent_directory"
  fi

  # Ensure Git is installed & executable, else exit the script execution safely
  if [[ $(command -v git &> /dev/null) ]]; then
    error "Git not found...please ensure its installed and executable!"
    exit 1
  fi

  # Loop through the list of plugins to install
  for plugin_url in "${plugins[@]}"; do
    plugin_name=$(basename "$plugin_url" .git)

    target_dir="$plugins_parent_directory/$plugin_name"

    # If the plugins wasn't already installed, download it locally
    if [[ ! -d "$target_dir" ]]; then
      git clone "$plugin_url" "$target_dir"
    fi
  done

  success "ZSH plugins installation complete!"

  info "The plugins will be usable after a system restart..."
}

###############################################################################
# Setup the dotfiles and related configuration files
###############################################################################
setup_dotfiles() {
  info "Preparing to download and setup the dotfiles..."

  # Check if git is installed & executable else exit safely
  if ! command -v git &> /dev/null; then
    error "Git not found...please ensure its installed and executable!"
    exit 1
  fi

  git clone https://github.com/Jarmos-san/dotfiles "$HOME"/.dotfiles

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
# Install Homebrew only on Linux and MacOS systems
###############################################################################
install_homebrew() {
  installation_script=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

  if [[ $(uname -s) == "Darwin" ]] || [[ $(uname) == "Linux" ]]; then
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl --fail --silent --show-error --location ${installation_script})"
  fi
}

###############################################################################
# Install Homebrew packages on either Linux or MacOS systems
###############################################################################
install_homebrew_packages() {
  linux_brewfile=$HOME/.dotfiles/dotfiles/linux.Brewfile
  macos_brewfile=$HOME/.dotfiles/dotfiles/macos.Brewfile

  if [[ ! $(command -v brew &> /dev/null) ]]; then
    error "Homebrew not found...aborting package installation!"
    exit 1
  fi

  if [[ $(uname -s) == "Linux" ]] && [[ -e $linux_brewfile ]] && [[ -f $linux_brewfile ]]; then
    brew bundle --file "$linux_brewfile"
  fi

  if [[ $(uname -s) == "Darwin" ]] && [[ -e $macos_brewfile ]] && [[ -f $macos_brewfile ]]; then
    brew bundle --file "$macos_brewfile"
  fi
}

###############################################################################
# Setup ZSH as the default shell
###############################################################################
setup_zsh() {
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(command -v zsh)" "${USER}"
}

###############################################################################
# Setup Git credentials (and potentially other things like SSH access and more!)
###############################################################################
setup_git() {
  git_config_dir="$HOME/.config/git"

  if [[ ! -d $git_config_dir ]]; then
    mkdir --parents "$git_config_dir"
  else
    echo "Failed to create the ${git_config_dir} directory!"
    exit 1
  fi

  cat << EOF > "${git_config_dir}"/credentials
[user]
  email = $git_email
  name = $git_name
EOF
}

###############################################################################
# The entrypoint of the script which will run the script as per the prescribed
# logic
###############################################################################
main() {
  # Perform a preliminary system update before starting the automated setup
  update_system

  # Ensure certain folders are present and/or created for a smooth operation
  create_necessary_dirs

  # FIXME: Identify ways to automate SSH setup
  # Setup SSH for Git/GitHub for cloning/managing the dotfiles itself
  # setup_github_ssh

  echo "Setting up system automatically!"

  # Install the fonts for systems with a Linux DE (excluding WSL2 environments)
  setup_fonts

  # Install prerequisite tools before the automated setup
  install_prerequisite_tools

  # Install and setup the "lazy.nvim" package manager for Neovim
  install_lazy_nvim

  # Install all necessary ZSH plugins
  install_zsh_plugins

  # Setup the dotfiles (like setting up the symlinks and so on)
  setup_dotfiles

  # Install the Homebrew package manager
  install_homebrew

  # Install necessary tools using the Homebrew package manager
  install_homebrew_packages

  # Make ZSH the default interactive shell environment
  setup_zsh

  # Setup Git to work well with GitHub
  setup_git

  info "System setup complete! Please restart the system before usage."
}

# Defer running the script till the last moment for safety reasons
main "$@"