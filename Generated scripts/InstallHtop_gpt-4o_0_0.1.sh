mkdir -p /usr/local/htop310
cd /usr/local/htop310
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf 3.1.0.tar.gz --strip-components=1
./autogen.sh
./configure
make
make install
echo 'export PATH=$PATH:/usr/local/htop310/bin' >> /etc/profile
source /etc/profile