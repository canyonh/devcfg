#!/bin/bash -x

sudo systemctl start ssh
sudo dnf module install nodejs:18/common

# utility
sudo dnf module install pipenv
sudo dnf install corkscrew fd-find fzf zsh chsh
sudo systemctl start sshd

# nvim
sudo apt install -y neovim

# build tools and nvim support
sudo apt install -y build-essential gcc g++ cmake clang
pip install pynvim
npm i neovim:18

# install black
pip install black==22.6.0

# install pipenv via python. apt has wrong version which does not work with the others
pip install pipenv
