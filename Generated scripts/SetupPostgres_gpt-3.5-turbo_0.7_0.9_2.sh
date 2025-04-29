# To prevent the psql commands from prompting for input, you can use the -c flag with echo to pass the commands directly to psql non-interactively.

# Install PostgreSQL
apt update
apt install postgresql

# Start PostgreSQL service
systemctl start postgresql

# Switch to postgres user
su - postgres

# Create a new database
createdb -p 5433 storedb

# Run init.sql on the database
psql -p 5433 -d storedb -f init.sql

# Create a read-only user with access to "common_data" schema
echo "CREATE ROLE public_view WITH LOGIN PASSWORD 'fox';" | psql -p 5433 -d storedb
echo "GRANT USAGE ON SCHEMA common_data TO public_view;" | psql -p 5433 -d storedb
echo "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;" | psql -p 5433 -d storedb