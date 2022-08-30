#!/bin/bash -x
ln -s $HOME/devcfg/.config/nvim $HOME/.config/nvim

pip install pynvim
npm install neovim

# does not work
#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
