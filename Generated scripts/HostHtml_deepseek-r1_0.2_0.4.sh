mkdir -p /usr/html
chmod -R a+rX /usr/html
sed -i '/^[[:space:]]*root /s|/var/www/html;|/usr/html;|' /etc/nginx/sites-available/default
nginx -t && systemctl reload nginx