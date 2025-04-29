#!/bin/bash
apt-get update && apt-get install -y build-essential autoconf automake pkg-config libncurses-dev wget
mkdir -p /usr/local/htop310
wget -O /tmp/htop-3.1.0.tar.gz https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf /tmp/htop-3.1.0.tar.gz -C /tmp
cd /tmp/htop-3.1.0 || exit 1
autoreconf -i
./configure --prefix=/usr/local/htop310
make && make install
echo "export PATH=\"\$PATH:/usr/local/htop310/bin\"" > /etc/profile.d/htop310.sh
chmod +x /etc/profile.d/htop310.sh
. /etc/profile.d/htop310.sh