#!/bin/bash -x

# update repo and packages
sudo sh -c "curl -fsSL https://deb.nodesource.com/setup_18.x | bash -"
sudo add-apt-repository ppa:neovim-ppa/stable
apt update

# utility
sudo apt install -y git python-is-python3 python3 python3-pip python3-venv openssh-server corkscrew ripgrep fd-find cppcheck

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

# install pipenv via python. apt has wrong info
pip install pipenv
