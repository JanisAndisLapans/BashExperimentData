# Create an Nginx server block configuration for hosting index.html

cat > /etc/nginx/sites-available/my_site <<EOF
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/html;
        index index.html;
    }
}
EOF

# Enable the configuration by creating a symbolic link to sites-enabled
ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/

# Test the Nginx configuration for syntax errors
nginx -t

# Reload Nginx to apply the changes
systemctl reload nginx