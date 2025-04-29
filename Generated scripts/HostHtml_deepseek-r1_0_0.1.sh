#!/bin/bash
# Configure nginx to serve from /usr/html
sed -i '/root \/var\/www\/html;/c\        root /usr/html;' /etc/nginx/sites-available/default
# Ensure permissions and restart nginx
chmod -R a+r /usr/html
find /usr/html -type d -exec chmod a+x {} \;
nginx -t && systemctl restart nginx