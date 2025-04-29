mkdir -p /usr/html
echo "<!DOCTYPE html><html><head><title>Welcome</title></head><body><h1>Hello, World!</h1></body></html>" > /usr/html/index.html
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
nginx -t && systemctl restart nginx