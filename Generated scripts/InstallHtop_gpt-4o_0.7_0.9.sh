# Download and extract Htop source code
mkdir -p /usr/local/htop310
cd /usr/local/htop310
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz
tar -xzf 3.1.0.tar.gz --strip-components=1

# Install necessary dependencies for building Htop
apt update
apt install -y build-essential autotools-dev autoconf libncurses5-dev

# Compile and install Htop
./autogen.sh
./configure
make
make install

# Add Htop binary to PATH
echo 'export PATH=$PATH:/usr/local/htop310' >> /etc/profile
source /etc/profile