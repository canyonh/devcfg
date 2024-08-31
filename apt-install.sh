#!/bin/bash -x

# update repo and packages, included nodejs is too old for neovim
sudo apt update -y 
sudo apt install -y curl
sudo sh -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"
sudo apt update -y
sudo apt install nodejs -y
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:aslatter/ppa
sudo apt update -y

# install tools
sudo apt install -y curl alacritty

# set alacrity as default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# utility
sudo apt install -y git python-is-python3 python3 python3-pip python3-venv software-properties-common openssh-server corkscrew ripgrep fd-find cppcheck fzf zsh

# nvim
# sudo apt install -y neovim

# tmux
sudo apt install -y tmux

# build tools and nvim support
sudo apt install -y build-essential gcc g++ cmake clang libclang-dev mold

#pip install --user pynvim
sudo apt install -y python3-pynvim

# failed -> check why
#sudo apt install -y python3-debugpy
npm install neovim

# install black
#pip install --user black

# disable caps lock
xmodmap -e "keycode 66 ="


