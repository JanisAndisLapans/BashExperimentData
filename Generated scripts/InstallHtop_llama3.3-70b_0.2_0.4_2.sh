wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xvf 3.1.0.tar.gz
mkdir -p /usr/local/htop310
mv htop-3.1.0 /usr/local/htop310
cd /usr/local/htop310/htop-3.1.0 || exit
./autogen.sh || exit
./configure --prefix=/usr/local/htop310 || exit
make || exit
make install || exit
echo "export PATH=$PATH:/usr/local/htop310/bin" >> /root/.bashrc
source /root/.bashrc