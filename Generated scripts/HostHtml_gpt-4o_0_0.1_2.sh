# Remove the existing server block configuration to avoid conflicts
rm /etc/nginx/sites-enabled/default

# Create a new Nginx server block configuration file
cat > /etc/nginx/sites-available/my_site << 'EOF'
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/html;
        index index.html;
    }
}
EOF

# Enable the new server block by creating a symbolic link
ln -sf /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/

# Test the Nginx configuration for syntax errors
nginx -t

# Reload Nginx to apply the changes
systemctl reload nginx