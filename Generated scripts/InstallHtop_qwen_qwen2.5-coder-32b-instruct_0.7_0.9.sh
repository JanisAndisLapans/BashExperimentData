cd /usr/local
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf 3.1.0.tar.gz
mv htop-3.1.0 htop310
cd htop310
./configure --prefix=/usr/local/htop310
make
make install
echo 'export PATH=$PATH:/usr/local/htop310/bin' >> /etc/profile
source /etc/profile