#!/bin/bash -x

sudo dnf update
sudo dnf install openssh-server
sudo systemctl enable sshd.service
sudo systemctl restart sshd

# utility
sudo dnf install corkscrew fd-find fzf zsh chsh python3-pip
sudo dnf module install nodejs

# nvim
sudo dnf install neovim

# build tools and nvim support
sudo dnf install cmake gcc clang
pip install pynvim
npm i neovim:18

# install black
pip install black==22.6.0
