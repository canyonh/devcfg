# utility
sudo apt install -y git python3 python3-pip openssh-server corkscrew ripgrep

# nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# build tools and nvim support
sudo apt install build-essential gcc g++ cmake clang libclang-dev nodejs
pip install pynvim
npm -i neovim
