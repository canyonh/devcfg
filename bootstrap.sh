#!/bin/bash
source ./apt-install.sh
source ./install-nerd-fonts.sh
source ./setup-neovim.sh
source ./setup-tmux.sh
source ./setup-git.sh
source ./install-mold.sh

# leave this at the bottom since it requires a relog to 
source ./install-zsh.sh
