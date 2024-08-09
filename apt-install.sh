#!/bin/bash -x

# update repo and packages, included nodejs is too old for neovim
sudo apt update -y
sudo apt install curl
sudo sh -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"
sudo add-apt-repository ppa:neovim-ppa/unstable
apt update -y

# utility
sudo apt install -y git python-is-python3 python3 python3-pip python3-venv software-properties-common openssh-server corkscrew ripgrep fd-find cppcheck fzf zsh

# nvim
sudo apt install -y neovim

# tmux
sudo apt install -y tmux

# build tools and nvim support
sudo apt install -y build-essential gcc g++ cmake clang libclang-dev nodejs mold

#pip install --user pynvim
sudo apt install -y python3-pynvim
npm i neovim

# install black
#pip install --user black
