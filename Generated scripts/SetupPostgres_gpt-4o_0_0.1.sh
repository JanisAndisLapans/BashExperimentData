# Install PostgreSQL
apt update
apt install -y postgresql

# Update PostgreSQL to listen on port 5433
sed -i "s/#port = 5432/port = 5433/" /etc/postgresql/*/main/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Switch to the postgres user to create the database and user
sudo -i -u postgres bash << EOF

# Create the database "storedb"
psql -c "CREATE DATABASE storedb;"

# Run the init.sql script on the "storedb" database
psql -d storedb -f /path/to/init.sql

# Create the user "public_view" with password "fox"
psql -c "CREATE USER public_view WITH PASSWORD 'fox';"

# Grant read-only access to the "common_data" schema
psql -d storedb -c "GRANT CONNECT ON DATABASE storedb TO public_view;"
psql -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
psql -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
psql -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"

EOF