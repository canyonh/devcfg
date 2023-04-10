#!/bin/bash -x

# update repo and packages, included nodejs is too old for neovim
sudo apt update -y
sudo apt install curl
sudo sh -c "curl -fsSL https://deb.nodesource.com/setup_18.x | bash -"
sudo add-apt-repository ppa:neovim-ppa/stable
apt update

# utility
sudo apt install -y git python-is-python3 python3 python3-pip python3-venv openssh-server corkscrew ripgrep fd-find cppcheck fzf zsh

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

# install pipenv via python. apt has wrong version which does not work with the others
pip install pipenv
