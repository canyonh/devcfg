#!/bin/bash
if [ -f /etc/fedora-release ]; then
	echo "Feroda release detected"
	source ./dnf-install.sh
elif [ -f /etc/lsb-release ]; then
	echo "Ubuntu release detected"
	source ./apt-install.sh
fi
source ./install_nerd_fonts.sh
source ./setup-neovim.sh
source ./setup-tmux.sh
source ./setup-git.sh
source ./install-mold.sh

# leave this at the bottom since it requires a relog to 
source ./install-zsh.sh
