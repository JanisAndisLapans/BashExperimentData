#!/bin/bash

# Install PostgreSQL
apt update
apt install -y postgresql postgresql-contrib

# Stop PostgreSQL service
systemctl stop postgresql

# Modify PostgreSQL to listen on port 5433
sed -i "s/#port = 5432/port = 5433/" /etc/postgresql/13/main/postgresql.conf

# Allow connections on the new port
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/13/main/pg_hba.conf

# Start PostgreSQL service
systemctl start postgresql

# Create database storedb
sudo -u postgres psql -c "CREATE DATABASE storedb;"

# Run init.sql on storedb
sudo -u postgres psql -d storedb -f ./init.sql

# Create user public_view with password 'fox'
sudo -u postgres psql -c "CREATE USER public_view WITH PASSWORD 'fox';"

# Grant read-only access to schema common_data for user public_view
sudo -u postgres psql -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
sudo -u postgres psql -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
sudo -u postgres psql -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"

# Reload PostgreSQL to apply changes
systemctl reload postgresql