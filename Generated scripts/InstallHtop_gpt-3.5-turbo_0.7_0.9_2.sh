# Install necessary build tools
apt update
apt install -y build-essential

# Download the source code
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz

# Extract the source code
mkdir /usr/local/htop310
tar -xzvf htop-3.1.0.tar.gz -C /usr/local/htop310 --strip-components=1

# Compile and install htop
cd /usr/local/htop310 || exit
./autogen.sh
./configure
make
make install

# Add htop binary to the path
ln -sf /usr/local/htop310/htop /usr/local/bin/htop