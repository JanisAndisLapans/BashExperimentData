# Create the installation directory
mkdir -p /usr/local/htop310

# Navigate to the installation directory
cd /usr/local/htop310

# Download the Htop source code
wget https://github.com/htop-dev/htop/archive/refs/tags/3.1.0.tar.gz -O htop-3.1.0.tar.gz

# Extract the tar.gz archive
tar -xzf htop-3.1.0.tar.gz --strip-components=1

# Compile and install Htop
./autogen.sh
./configure --prefix=/usr/local/htop310
make
make install

# Add Htop binary to PATH
echo 'export PATH=/usr/local/htop310/bin:$PATH' >> /etc/profile
source /etc/profile