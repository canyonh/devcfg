# todo
pushd .

mkdir -p $HOME/source
cd $HOME/source

git clone https://github.com/rui314/mold.git
cd mold
git checkout v1.4.2
make -j$(nproc) CXX=g++
sudo make install

popd
