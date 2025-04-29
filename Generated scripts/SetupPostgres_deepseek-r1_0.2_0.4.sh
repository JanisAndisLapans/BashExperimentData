#!/bin/bash

apt update
apt install -y postgresql postgresql-contrib

VERSION=$(ls /etc/postgresql | sort -V | tail -n1)
CONFIG_FILE="/etc/postgresql/$VERSION/main/postgresql.conf"
sed -i -E "s/^#?\s*port\s*=\s*[0-9]+/port = 5433/" "$CONFIG_FILE"
systemctl restart postgresql

sudo -u postgres psql -c "CREATE DATABASE storedb;"
sudo -u postgres psql -d storedb -f init.sql

sudo -u postgres psql -c "CREATE USER public_view WITH PASSWORD 'fox';"
sudo -u postgres psql -d storedb << EOF
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
EOF