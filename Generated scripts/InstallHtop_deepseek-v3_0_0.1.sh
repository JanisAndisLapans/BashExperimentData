#!/bin/bash

# Install required dependencies
apt update && apt install -y build-essential autoconf automake libncurses-dev

# Create the target directory
mkdir -p /usr/local/htop310

# Download and extract htop
cd /tmp
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz
tar xzf htop-3.1.0.tar.gz
cd htop-3.1.0

# Compile and install
./autogen.sh
./configure --prefix=/usr/local/htop310
make -j$(nproc)
make install

# Add to PATH
echo 'export PATH=/usr/local/htop310/bin:$PATH' > /etc/profile.d/htop310.sh
chmod +x /etc/profile.d/htop310.sh
source /etc/profile.d/htop310.sh