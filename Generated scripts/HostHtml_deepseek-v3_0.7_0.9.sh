# Install nginx if not already installed
apt update && apt install -y nginx

# Create the default nginx site config
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

# Create the html directory if it doesn't exist
mkdir -p /usr/html

# Create a basic index.html if it doesn't exist
if [ ! -f /usr/html/index.html ]; then
    cat > /usr/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome to nginx!</h1>
</body>
</html>
EOF
fi

# Restart nginx to apply changes
systemctl restart nginx