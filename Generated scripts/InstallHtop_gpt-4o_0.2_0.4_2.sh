mkdir -p /usr/local/htop310
cd /usr/local/htop310 || exit
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf 3.1.0.tar.gz --strip-components=1
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install

echo 'export PATH=$PATH:/usr/local/htop310/bin' >> /etc/profile.d/htop310.sh
source /etc/profile.d/htop310.sh