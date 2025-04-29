#!/bin/bash
apt install -y build-essential autoconf automake libtool libncurses-dev pkg-config libhwloc-dev libsensors-dev
mkdir -p /usr/local/htop310
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O /tmp/htop-3.1.0.tar.gz
tar xzf /tmp/htop-3.1.0.tar.gz -C /tmp/
cd /tmp/htop-3.1.0 || exit 1
./autogen.sh
./configure --prefix=/usr/local/htop310
make -j"$(nproc)"
make install
echo "export PATH=\"\$PATH:/usr/local/htop310/bin\"" > /etc/profile.d/htop310.sh
chmod +x /etc/profile.d/htop310.sh
. /etc/profile.d/htop310.sh