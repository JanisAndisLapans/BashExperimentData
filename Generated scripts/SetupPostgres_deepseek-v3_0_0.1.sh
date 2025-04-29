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
sudo -u postgres psql -p 5433 -c "CREATE USER public_view WITH PASSWORD 'fox';"
sudo -u postgres psql -p 5433 -d storedb -c "GRANT CONNECT ON DATABASE storedb TO public_view;"
sudo -u postgres psql -p 5433 -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
sudo -u postgres psql -p 5433 -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
sudo -u postgres psql -p 5433 -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"

echo "PostgreSQL setup complete on port 5433"