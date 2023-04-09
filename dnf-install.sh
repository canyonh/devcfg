#!/bin/bash -x

sudo dnf update
sudo dnf install openssh-server
sudo systemctl enable sshd.service
sudo systemctl restart sshd

# fzf has a bug in fedora which tab completion does not work. use git install script for now
#sudo dnf install corkscrew fd-find fzf zsh python3-pip util-linux-user
sudo dnf install corkscrew fd-find zsh python3-pip util-linux-user
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
sudo dnf module install nodejs

# nvim
sudo dnf install neovim

# build tools and nvim support
sudo dnf install cmake gcc clang
pip install pynvim
#npm i neovim:18
npm i neovim

# install black
pip install black==22.6.0

# install mold
sudo dnf config-manager --add-repo https://mold-lang.github.io/fedora/mold-lang.repo
sudo rpm --import https://mold-lang.github.io/fedora/mold-lang.pub
sudo dnf install mold
