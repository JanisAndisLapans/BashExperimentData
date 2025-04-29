# Install PostgreSQL
apt update
apt install -y postgresql

# Update PostgreSQL to listen on port 5433
sed -i "s/#port = 5432/port = 5433/" /etc/postgresql/*/main/postgresql.conf

# Start PostgreSQL service
systemctl restart postgresql

# Ensure init.sql has the correct permissions
chmod 644 /root/init.sql

# Switch to the postgres user to setup the database
sudo -i -u postgres bash << EOF

# Create the "storedb" database
psql -c "CREATE DATABASE storedb;"

# Run the SQL script
psql -d storedb -f /root/init.sql

EOF

# Switch to the postgres user to setup the user and permissions
sudo -i -u postgres bash << EOF

# Create the "public_view" user with password "fox"
psql -c "CREATE USER public_view WITH PASSWORD 'fox';"

# Create the schema "common_data" if it doesn't exist
psql -d storedb -c "CREATE SCHEMA IF NOT EXISTS common_data;"

# Grant read-only access to the "public_view" user on the "common_data" schema
psql -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
psql -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
psql -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"

EOF