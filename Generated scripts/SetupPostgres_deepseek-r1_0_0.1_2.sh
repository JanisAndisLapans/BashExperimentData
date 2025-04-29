#!/bin/bash

apt update && apt install -y postgresql postgresql-contrib

PG_CONF=$(find /etc/postgresql/*/main/postgresql.conf -type f | head -n1)
sed -i "s/^#*listen_addresses.*/listen_addresses = '*'/" "$PG_CONF"
sed -i "s/^#*port.*/port = 5433/" "$PG_CONF"
systemctl restart postgresql

sudo -u postgres createdb -p 5433 storedb
sudo -u postgres psql -p 5433 -d storedb -f init.sql

# Add default privileges for future tables in the schema
sudo -u postgres psql -p 5433 -c "CREATE USER public_view WITH PASSWORD 'fox';"
sudo -u postgres psql -p 5433 -d storedb <<EOSQL
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
EOSQL