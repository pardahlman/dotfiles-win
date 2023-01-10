#!/bin/bash

echo "Setting up WSL for user $1. Assuming dotfiles repo is available at $PWD."

echo "Creating symlinks for config files"
mkdir -p ~/.config/fish/
ln -sf $PWD/config/fish/config.fish ~/.config/fish/config.fish
ln -sf $PWD/config/git/gitconfig ~/.gitconfig
ln -sf $PWD/config/git/gitignore ~/.gitignore
ln -sf $PWD/config/git/gitattributes ~/.gitattributes
ln -sf $PWD/config/bash/profile ~/.profile

if [ ! -f ~/.gitconfig.local ]; then
    echo "Creating .gitconfig.local with git-credential-manager" 
    cp $PWD/config/git/gitconfig.local ~/.gitconfig.local
    echo "[credential]" >> ~/.gitconfig.local
    echo "  helper = /mnt/c/Users/$1/scoop/apps/git/current/mingw64/bin/git-credential-manager.exe" >> ~/.gitconfig.local
fi

# Install fish shell
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update && sudo apt upgrade -y
sudo apt install fish -y

# Install .NET 7.0
wget https://packages.microsoft.com/config/ubuntu/22.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update && \
  sudo apt-get install -y \
  dotnet-sdk-6.0 \
  dotnet-sdk-7.0

# More apt install
sudo apt update && sudo apt install -y \
    fish \
    bat \
    fd-find \
    fzf \
    exa \
    zsh

# TODO: make non-interactive install work
# Documentation: https://docs.brew.sh/Installation#unattended-installation
if [ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if ! command -v brew &> /dev/null
then
    echo "brew command not found."
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install starship
brew install fisher
brew install z
brew install git-delta

fish -c 'alias --save bat="batcat"'
fish -c 'alias --save fd="fdfind"'
fish -c 'fisher install pardahlman/z@brew-prefix'
fish -c 'fisher install PatrickF1/fzf.fish'
