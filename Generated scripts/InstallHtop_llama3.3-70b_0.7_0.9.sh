wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xvf 3.1.0.tar.gz
mkdir -p /usr/local/htop310
cd htop-3.1.0
./configure --prefix=/usr/local/htop310
make
make install
ln -s /usr/local/htop310/bin/htop /usr/local/bin/htop