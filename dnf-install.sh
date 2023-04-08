#!/bin/bash -x

sudo dnf update
sudo dnf install openssh-server
sudo systemctl start sshd
sudo dnf module install nodejs

# utility
sudo dnf install corkscrew fd-find fzf zsh chsh
sudo systemctl start sshd

# nvim
sudo dnf install neovim

# build tools and nvim support
sudo dnf install cmake gcc clang
pip install pynvim
npm i neovim:18

# install black
pip install black==22.6.0
