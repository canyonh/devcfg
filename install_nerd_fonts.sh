mkdir -p ~/.local/share/fonts

pushd .
cd ~/.local/share/fonts
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip Hack-v3.003-ttf.zip 
rm Hack-v3.003-ttf.zip
fc-cache -f -v
popd
