#!/bin/bash

# Download libgraph
wget http://download.savannah.gnu.org/releases/libgraph/libgraph-1.0.2.tar.gz
tar -xvzf libgraph-1.0.2.tar.gz

# Install dependencies
sudo apt install build-essential
sudo apt-get install libsdl-image1.2 libsdl-image1.2-dev guile-2.0 \
guile-2.0-dev libsdl1.2debian libart-2.0-dev libaudiofile-dev \
libdirectfb-dev libdirectfb-extra libfreetype6-dev \
libxext-dev x11proto-xext-dev libfreetype6 libaa1 libaa1-dev \
libslang2-dev libasound2 libasound2-dev

# Add repositories
echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main universe" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ xenial main universe" | sudo tee -a /etc/apt/sources.list

# Update and install libesd0-dev
sudo apt-get update && sudo apt-get install libesd0-dev

# Build and install libgraph
cd libgraph-1.0.2
sudo CPPFLAGS="$CPPFLAGS $(pkg-config --cflags-only-I guile-2.0)" \
  CFLAGS="$CFLAGS $(pkg-config --cflags-only-other guile-2.0)" \
  LDFLAGS="$LDFLAGS $(pkg-config --libs guile-2.0)" \
  ./configure
sudo make
sudo make install
sudo cp /usr/local/lib/libgraph.* /usr/lib

# Download sample.cpp
cd /home/$USER/Desktop
wget -O sample.cpp https://pastebin.com/raw/BDiVk0uX

# Compile and run sample.cpp
gcc sample.cpp -o sample -lgraph
./sample
