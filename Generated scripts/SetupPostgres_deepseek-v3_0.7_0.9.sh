#!/bin/bash

# Install PostgreSQL
apt update
apt install -y postgresql postgresql-client

# Configure PostgreSQL to listen on port 5433
sed -i "s/^#listen_addresses =.*/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
echo "port = 5433" >> /etc/postgresql/*/main/postgresql.conf

# Allow connections from localhost to port 5433
echo "host    all             all             127.0.0.1/32            md5" >> /etc/postgresql/*/main/pg_hba.conf

# Restart PostgreSQL
systemctl restart postgresql

# Create database and run init.sql
sudo -u postgres psql -p 5433 -c "CREATE DATABASE storedb;"
sudo -u postgres psql -p 5433 -d storedb -f init.sql

# Create read-only user and grant permissions
sudo -u postgres psql -p 5433 -d storedb <<EOF
CREATE ROLE public_view WITH LOGIN PASSWORD 'fox';
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
EOF

echo "PostgreSQL setup complete:"
echo "- Running on port 5433"
echo "- Database 'storedb' created"
echo "- User 'public_view' with password 'fox' created"
echo "- Read-only access granted to schema 'common_data'"