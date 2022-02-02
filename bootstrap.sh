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

# TODO: Refactor into a function
echo "Downloading personal projects"
cd projects
git clone git@github.com:Jarmos-san/blog
git clone git@github.com:Jarmos-san/jarvim

echo "Downloading dotfiles from remote repository"
git clone git@github.com:Jarmos-san/dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles

echo "Install necessary software as listed in Brewfile"
brew bundle --no-lock --file=$HOME/.dotfiles/Brewfile

# TODO: Create symlinks using "stow"
