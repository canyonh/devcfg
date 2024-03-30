#!/bin/bash -x
if [ -f /etc/fedora-release ]; then
	echo "Feroda release detected"
	source ./dnf-install.sh
	source ./install_nerd_fonts.sh
	source ./setup-neovim.sh
	source ./setup-tmux.sh
	source ./setup-git.sh
	source ./install-zsh.sh
elif [ -f /etc/lsb-release ]; then
	echo "Ubuntu release detected"
	source ./apt-install.sh
	source ./install_nerd_fonts.sh
	source ./setup-neovim.sh
	source ./setup-tmux.sh
	#source ./install-mold.sh
	source ./install-zsh.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo "MacOsx release detected"
	source ./homebrew-install.sh
	source ./setup-neovim.sh
	source ./setup-tmux.sh
	# tbd don't know if we are going to need it
	#source ./install-mold.sh
	source ./install-zsh.sh
fi
