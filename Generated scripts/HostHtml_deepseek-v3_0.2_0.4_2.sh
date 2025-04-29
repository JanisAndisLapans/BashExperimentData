# Ensure nginx is installed
apt update && apt install -y nginx

# Create HTML directory and index file with proper permissions
mkdir -p /usr/html
echo "<html><body><h1>Welcome to Nginx</h1></body></html>" > /usr/html/index.html
chown -R www-data:www-data /usr/html
chmod -R 755 /usr/html

# Create proper nginx configuration
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /usr/html;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# Remove default symlink and create new one
rm -f /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Test configuration and restart nginx
nginx -t && systemctl restart nginx

# Enable nginx to start on boot
systemctl enable nginx