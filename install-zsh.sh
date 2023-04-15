#!/bin/bash -x

# zsh
# moved to install-apt
echo "export ZDOTDIR=$HOME/devcfg/.config/zsh" > ~/.zshenv

if [ ! "$SHELL" == "/usr/bin/zsh" ]; then
  chsh -s $(which zsh)
  echo "Install and changing shell to zsh, relogin to continue"
  exit 1;
fi
