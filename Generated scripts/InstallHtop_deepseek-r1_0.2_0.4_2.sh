#!/bin/bash
set -e
apt-get update
apt-get install -y wget build-essential autoconf automake libtool libncurses-dev libhwloc-dev pkg-config
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O /tmp/htop-3.1.0.tar.gz
tar -xzf /tmp/htop-3.1.0.tar.gz -C /tmp/
cd /tmp/htop-3.1.0 || exit 1
./autogen.sh
./configure --prefix=/usr/local/htop310
make -j"$(nproc)"
make install
ln -sf /usr/local/htop310/bin/htop /usr/local/bin/htop