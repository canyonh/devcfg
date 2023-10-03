#!/bin/bash -x

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/kxhuan/.profile

# update homebrew
brew update && brew upgrade


#sudo systemctl start ssh
#sudo dnf module install nodejs:18/common
brew install node

# install python3
brew install python3

# utility
#sudo dnf install corkscrew fd-find fzf zsh chsh
#sudo systemctl start sshd
brew install corkscrew fd fzf zsh

# nvim
#sudo apt install -y neovim
#sudo dnf install neovim
brew install neovim

# build tools and nvim support
# moved to setup-neovim, and clang is already there if you install x code command line tools
#sudo apt install -y build-essential gcc g++ cmake clang
#pip install pynvim
#npm i neovim
#pip3 install pynvim
#npm i neovim
brew install cmake

# install black
pip3 install black==22.6.0

# install nerd font
brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font

# install terminaal
brew install --cask iterm2

# install window snapping tools
brew install --cask rectangle

git lfs install
