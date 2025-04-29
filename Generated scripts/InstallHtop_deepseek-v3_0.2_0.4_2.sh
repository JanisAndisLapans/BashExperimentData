#!/bin/bash

# Install build dependencies
apt update && apt install -y build-essential autoconf automake libncurses-dev

# Create target directory
mkdir -p /usr/local/htop310

# Download and extract htop
cd /tmp || exit
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz
tar xzf htop-3.1.0.tar.gz
cd htop-3.1.0 || exit

# Compile and install
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install

# Add to PATH
echo 'export PATH=$PATH:/usr/local/htop310/bin' > /etc/profile.d/htop310.sh
chmod +x /etc/profile.d/htop310.sh
. /etc/profile.d/htop310.sh

# Verify installation
if /usr/local/htop310/bin/htop --version; then
    echo "htop successfully installed and added to PATH"
else
    echo "Installation failed" >&2
    exit 1
fi