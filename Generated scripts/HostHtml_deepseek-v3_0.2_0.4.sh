# Install nginx if not already installed
apt update && apt install -y nginx

# Create the HTML directory and index file
mkdir -p /usr/html
echo "<html><body><h1>Welcome to Nginx</h1></body></html>" > /usr/html/index.html

# Configure nginx to serve from /usr/html
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /usr/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Test configuration and restart nginx
nginx -t && systemctl restart nginx