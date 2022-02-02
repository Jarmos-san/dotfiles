#!/usr/bin/env bash

echo "Boostrapping your machine now! Beware, some files could be overwritten"

echo "The system will be updated right now! Other prerequisite tools like Git & cURL will be installed as well."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git curl
echo "System update complete!"
sleep 3

echo "Installing Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
echo "Homebrew installation complete!"
sleep 3

echo "Creating necessary folders"
mkdir -p "projects" "work"

# Function for cloning remote repositories to a specified location in the local repository
function clone_repo {
  repo=$1
  git clone git@github.com:Jarmos-san/$repo $2
}

PROJECT_DIR="$HOME/projects"
DOTFILES_DIR="$HOME/.dotfiles"

# Attempted a refactor but need more guidance on how to do ie
echo "Downloading personal projects"
clone_repo "blog" $PROJECT_DIR
clone_repo "jarvim" $PROJECT_DIR

echo "Downloading dotfiles from remote repository"
clone_repo "dotfiles" $DOTFILES_DIR

echo "Install necessary software as listed in Brewfile"
brew bundle --no-lock --file=$DOTFILES_DIR/Brewfile

# TODO: Create symlinks using "stow"
