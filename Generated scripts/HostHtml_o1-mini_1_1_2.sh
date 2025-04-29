# Create the web root directory
mkdir -p /usr/html

# Create the index.html file
echo "<!DOCTYPE html><html><head><title>Welcome</title></head><body><h1>Hello, World!</h1></body></html>" > /usr/html/index.html

# Set appropriate permissions
chmod -R 755 /usr/html

# Remove the default Nginx site configuration
rm -f /etc/nginx/sites-enabled/default

# Create a new Nginx site configuration
cat > /etc/nginx/sites-available/my_site <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    root /usr/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Enable the new site by creating a symbolic link
ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/

# Test Nginx configuration and restart the service
nginx -t && systemctl restart nginx