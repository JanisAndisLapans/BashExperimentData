# Install Postgres
apt install -y postgresql postgresql-contrib

# Stop Postgres service
service postgresql stop

# Edit Postgres configuration to use port 5433
sed -i 's/port = 5432/port = 5433/' /etc/postgresql/13/main/postgresql.conf

# Start Postgres service
service postgresql start

# Create database "storedb"
psql -U postgres -c "CREATE DATABASE storedb;"

# Run init.sql on "storedb"
psql -U postgres -d storedb -f init.sql

# Create user "public_view" with password "fox"
psql -U postgres -d storedb -c "CREATE ROLE public_view WITH PASSWORD 'fox';"

# Grant read-only access to schema "common_data" for user "public_view"
psql -U postgres -d storedb -c "GRANT SELECT ON SCHEMA common_data TO public_view;"
psql -U postgres -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
psql -U postgres -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"