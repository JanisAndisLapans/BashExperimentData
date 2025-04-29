sed -i 's|root /var/www/html;|root /usr/html;|' /etc/nginx/sites-available/default && \
nginx -t && systemctl reload nginx