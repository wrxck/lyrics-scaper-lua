#!/bin/sh
if [ $(lsb_release -r | cut -f 2) == "16.04" ]; then
    luaver="5.3"
else
    luaver="5.2"
fi
echo "This script will request root privileges to install the required dependencies."
echo "Press enter to continue. Use Ctrl-C to exit."
read
sudo apt-get update
sudo apt-get install -y lua$luaver liblua$luaver-dev git libssl-dev fortune-mod fortunes unzip make
git clone http://github.com/keplerproject/luarocks
cd luarocks
./configure --lua-version=$luaver --versioned-rocks-dir --lua-suffix=$luaver
make build
sudo make install
sudo luarocks-$luaver install luasocket
sudo -k
cd ..
