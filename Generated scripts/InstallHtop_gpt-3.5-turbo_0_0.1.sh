# Install required build tools
apt update
apt install -y build-essential

# Download htop source code
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz

# Extract the source code
mkdir -p /usr/local/htop310
tar -xzf htop-3.1.0.tar.gz -C /usr/local/htop310 --strip-components=1

# Compile and install htop
cd /usr/local/htop310
./autogen.sh
./configure
make
make install

# Add htop binary to the system path
ln -s /usr/local/bin/htop /usr/local/htop310/htop

# Clean up
rm htop-3.1.0.tar.gz