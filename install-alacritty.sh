sudo add-apt-repository ppa:aslatter/ppa
sudo apt update
sudo apt install alacritty
ln -s $HOME/devcfg/.config/alacritty $/HOME/.config/alacritty

# to remove
# sudo apt remove --auto-remove alacritty
# sudo add-apt-repository --remove ppa:aslatter/ppa

# to setup short cut ctrl-alt-t to open alacritty:
#  * Open keyboard -> shortcuts
#  * Remove launch terminal shortcut in launchers
#  * Add custom short cut ctrl-alt-t to alacritty
