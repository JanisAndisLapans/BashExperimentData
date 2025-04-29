# Install PostgreSQL
apt update && apt install -y postgresql

# Change PostgreSQL to listen on port 5433
sed -i "s/^#*port = .*/port = 5433/" /etc/postgresql/*/main/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Create the storedb database
sudo -u postgres createdb storedb

# Run init.sql on storedb
sudo -u postgres psql -d storedb -f "$(pwd)/init.sql"

# Create user public_view with password 'fox' and grant read-only access
sudo -u postgres psql -d storedb <<EOF
CREATE USER public_view WITH PASSWORD 'fox';
GRANT USAGE ON SCHEMA common_data TO public_view;
GRANT SELECT ON ALL TABLES IN SCHEMA common_data TO public_view;
ALTER DEFAULT PRIVILEGES IN SCHEMA common_data GRANT SELECT ON TABLES TO public_view;
EOF