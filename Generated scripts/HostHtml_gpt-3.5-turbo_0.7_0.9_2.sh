apt update
apt install nginx
mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html_backup
cp /usr/html/index.html /usr/share/nginx/html/
systemctl restart nginx