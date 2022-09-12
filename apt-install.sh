#!/bin/bash -x

# update repo and packages
sudo add-apt-repository ppa:neovim-ppa/stable
apt update

# utility
sudo apt install -y git python-is-python3 python3 python3-pip python3-venv openssh-server corkscrew ripgrep fd-find pipenv cppcheck

# nvim
sudo apt install -y neovim

# tmux
sudo apt install -y tmux

# build tools and nvim support
sudo apt install -y build-essential gcc g++ cmake clang libclang-dev nodejs npm
pip install pynvim
npm i neovim

# install black
pip install black==22.6.0

