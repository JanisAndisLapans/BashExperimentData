# Install PostgreSQL
apt update
apt install postgresql

# Change port to 5433
sed -i 's/port = 5432/port = 5433/' /etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Create database "storedb"
sudo -u postgres psql -c "CREATE DATABASE storedb;"

# Run init.sql on "storedb"
sudo -u postgres psql -d storedb -f init.sql

# Create user "public_view" with read-only access to schema "common_data"
sudo -u postgres psql -d storedb -c "CREATE USER public_view WITH PASSWORD 'fox';"
sudo -u postgres psql -d storedb -c "GRANT USAGE ON SCHEMA common_data TO public_view;"
sudo -u postgres psql -d storedb -c "GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;"