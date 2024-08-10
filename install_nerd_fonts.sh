#!/bin/bash -x
mkdir -p ~/.local/share/fonts

pushd .
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
unzip -j Hack.zip 
rm Hack-v3.003-ttf.zip
fc-cache -f -v
popd

pushd .
mkdir -p ~/.config/alacritty
cd ~/.config/alacritty
ln -s ~/devcfg/.config/alacritty/alacritty.yml
popd
