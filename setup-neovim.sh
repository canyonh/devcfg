#!/bin/bash -x
ln -s $HOME/devcfg/.config/nvim $HOME/.config/nvim

pip install pynvim
npm install neovim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
