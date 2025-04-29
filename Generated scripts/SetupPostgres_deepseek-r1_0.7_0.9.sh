#!/bin/bash

# Install PostgreSQL
apt-get update
apt-get install -y postgresql postgresql-contrib

# Configure to use port 5433
sed -i "s/^#*port\s*=\s*[0-9]*/port = 5433/" /etc/postgresql/*/main/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Create database
sudo -u postgres createdb storedb

# Initialize database schema
sudo -u postgres psql -d storedb -f init.sql

# Create read-only user and set permissions
sudo -u postgres psql -d storedb <<EOF
CREATE ROLE public_view WITH LOGIN PASSWORD 'fox';
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
EOF