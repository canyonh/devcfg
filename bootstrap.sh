#!/bin/bash
source ./apt-install.sh
source ./install_nerd_fonts.sh
source ./setup-neovim.sh
source ./setup-tmux.sh
source ./setup-git.sh
source ./install-mold.sh

# leave this at the bottom since it requires a relog to 
source ./install-zsh.sh
