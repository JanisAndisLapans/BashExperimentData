mkdir -p /usr/local/htop310
wget -O /usr/local/htop310/htop-3.1.0.tar.gz https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf /usr/local/htop310/htop-3.1.0.tar.gz -C /usr/local/htop310 --strip-components=1
cd /usr/local/htop310 || exit
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install
echo 'export PATH=$PATH:/usr/local/htop310/bin' >> /etc/profile
source /etc/profile