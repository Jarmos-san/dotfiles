#!/usr/bin/env bash

echo "Boostrapping your machine now! Beware, some files could be overwritten"

# TODO: Programmatically identify if system is WSL or native Linux. Then
# write configuration at "/etc/wsl.conf". The config details are available at:
# https://github.com/Jarmos-san/dotfiles-windows/blob/master/configs/wsl/wsl.conf

echo "Installing Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# TODO: Check if "git" exists, if not install using Homebrew

echo "Creating necessary folders"
mkdir -p "projects" "work"

echo "Downloading personal projects"
cd projects
git clone git@github.com:Jarmos-san/blog
git clone git@github.com:Jarmos-san/jarvim

echo "Downloading dotfiles from remote repository"
git clone git@github.com:Jarmos-san/dotfiles ~/.dotfiles
cd ~/.dotfiles

echo "Install necessary software as listed in Brewfile"
brew bundle

# TODO: Create symlinks using "stow"

# TODO: Setup GPG & SSH

# TODO: Setup GitHub CLI. More info is available at: https://cli.github.com/manual

# For reference check the following repositories:
# - https://github.com/mathiasbynens/dotfiles
# - https://github.com/disrupted/dotfiles
# - https://github.com/driesvints/dotfiles
