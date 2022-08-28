#!/bin/bash -x

# update repo and packages
sudo add-apt-repository ppa:neovim-ppa/stable
apt update

# utility
sudo apt install -y git python3 python3-pip openssh-server corkscrew ripgrep fzf

# nvim
sudo apt install -y neovim

# tmux
sudo apt install -y tmux

# build tools and nvim support
sudo apt install build-essential gcc g++ cmake clang libclang-dev nodejs npm
pip install pynvim
npm i neovim

