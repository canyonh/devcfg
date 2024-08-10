#!/bin/bash -x
mkdir -p $HOME/.config
ln -s $HOME/devcfg/.config/nvim $HOME/.config/nvim
ln -s $HOME/devcfg/.config/clangd $HOME/.config/clangd

# pip3 install pynvim
# npm install neovim

# does not work
#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
