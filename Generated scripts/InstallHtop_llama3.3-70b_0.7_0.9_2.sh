wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xvf 3.1.0.tar.gz
mkdir -p /usr/local/htop310
cd htop-3.1.0 || exit
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install
echo "export PATH=$PATH:/usr/local/htop310/bin" >> /etc/profile
source /etc/profile