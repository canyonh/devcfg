#!/bin/bash -x

APP_SRC_ROOT_DIR=${HOME}/app_src
mkdir -p ${APP_SRC_ROOT_DIR}
pushd .

cd $APP_SRC_ROOT_DIR

sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

popd
