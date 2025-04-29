#!/bin/bash

# Install build dependencies
apt update && apt install -y build-essential autoconf automake libncurses-dev

# Create build directory
mkdir -p /usr/local/htop310 || exit 1
cd /usr/local/htop310 || exit 1

# Download and extract htop
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz
tar xzf htop-3.1.0.tar.gz
cd htop-3.1.0 || exit 1

# Build and install
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install

# Add to PATH
echo "export PATH=/usr/local/htop310/bin:\$PATH" > /etc/profile.d/htop310.sh
chmod +x /etc/profile.d/htop310.sh
. /etc/profile.d/htop310.sh

# Verify installation
if /usr/local/htop310/bin/htop --version; then
    echo "htop installed successfully and added to PATH"
else
    echo "htop installation failed" >&2
    exit 1
fi