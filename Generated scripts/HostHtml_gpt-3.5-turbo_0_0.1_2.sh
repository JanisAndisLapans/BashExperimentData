apt update
apt install nginx

echo "Hello, World!" > /usr/share/nginx/html/index.html

systemctl restart nginx