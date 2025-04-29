echo "server {
    listen 80;
    server_name example.com;

    location / {
        root /usr/html;
        index index.html;
    }
}" > /etc/nginx/sites-available/default

nginx -t
service nginx restart