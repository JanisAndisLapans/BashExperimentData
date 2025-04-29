# Ensure the init.sql file exists in the current directory
if [ ! -f init.sql ]; then
  echo "init.sql file not found in the current directory."
  exit 1
fi

# Install PostgreSQL
apt update
apt install -y postgresql

# Update PostgreSQL to listen on port 5433
sed -i "s/#port = 5432/port = 5433/" /etc/postgresql/*/main/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Switch to the postgres user to create the database and user
sudo -i -u postgres psql <<EOF
-- Create the database
CREATE DATABASE storedb;

-- Connect to the storedb database
\c storedb

-- Run the init.sql script
\i '$(pwd)/init.sql'

-- Create the user with read-only access
CREATE USER public_view WITH PASSWORD 'fox';

-- Create the schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS common_data;

-- Grant read-only access to the schema common_data
GRANT CONNECT ON DATABASE storedb TO public_view;
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;

-- Ensure future tables in schema common_data are accessible
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
EOF