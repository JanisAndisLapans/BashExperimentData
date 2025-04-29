#!/bin/bash

apt update
apt install -y postgresql postgresql-contrib

VERSION=$(find /etc/postgresql -maxdepth 1 -type d -name '*.*' -printf '%f\n' | sort -V | tail -n1)
CONFIG_FILE="/etc/postgresql/$VERSION/main/postgresql.conf"
sed -i -E "s/^#?\s*port\s*=\s*[0-9]+/port = 5433/" "$CONFIG_FILE"
systemctl restart postgresql

sudo -u postgres psql -c "CREATE DATABASE storedb;"
sudo -u postgres psql -d storedb -f init.sql

sudo -u postgres psql -c "CREATE USER IF NOT EXISTS public_view WITH PASSWORD 'fox';"
sudo -u postgres psql -d storedb << EOF
CREATE SCHEMA IF NOT EXISTS common_data;
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
EOF