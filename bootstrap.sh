#!/usr/bin/env bash

echo "Boostrapping your machine now! Beware, some files could be overwritten"

echo "The system will be updated right now! Other prerequisite tools like Git & cURL will be installed as well."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git curl
echo "System update complete!"
sleep 3

read -p "Please provide a password for authenticating SSH connections: " -s password

echo "Installing Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

echo "Creating necessary folders"
mkdir -p "projects" "work"

# TODO: Refactor into a function
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
echo "Setting up SSH"
ssh-keygen -t ed25519 -C somraj.mle@gmail.com -f ~/.ssh/id_ed25519 -N $password
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat > keyConfig <<EOF
    Key-Type: default
    Key-Length: 4096
    Subkey-Type: default
    Subkey-Length: 4096
    Name-Real: Somraj Saha
    Name-Comment: "GitHub GPG key for somraj.mle@gmail.com
    Name-Email: somraj.mle@gmail.com
    Expire-Date: 0
    Protection: $password
    %commit
EOF

echo "Generating GPG key...(this might take a while)"
gpg --batch --generate-key keyConfig
rm -rf keyConfig

# TODO: Use GitHub CLI to setup SSH & GPG keys for the account
