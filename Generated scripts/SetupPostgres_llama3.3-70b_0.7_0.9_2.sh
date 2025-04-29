# Install Postgres
apt install -y postgresql

# Stop Postgres service
service postgresql stop

# Edit Postgres config to use port 5433
sed -i 's/port = 5432/port = 5433/' /etc/postgresql/13/main/postgresql.conf

# Start Postgres service
service postgresql start

# Change Postgres authentication method to md5
sed -i 's/peer/md5/' /etc/postgresql/13/main/pg_hba.conf

# Restart Postgres service
service postgresql restart

# Create database storedb
psql -U postgres -p 5433 -c "CREATE DATABASE storedb;"

# Run init.sql on storedb
psql -U postgres -p 5433 -d storedb -f init.sql

# Create user public_view with password fox
psql -U postgres -p 5433 -d storedb -c "CREATE ROLE public_view WITH PASSWORD 'fox';"

# Grant read-only access to schema common_data for user public_view
psql -U postgres -p 5433 -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
psql -U postgres -p 5433 -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"
psql -U postgres -p 5433 -d storedb -c "ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;"