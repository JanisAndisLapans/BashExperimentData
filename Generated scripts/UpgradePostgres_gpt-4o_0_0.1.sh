# Stop the PostgreSQL 16 service
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Initialize a new cluster for PostgreSQL 17
pg_createcluster 17 main --start

# Upgrade the data from PostgreSQL 16 to 17
pg_upgradecluster 16 main

# Start the PostgreSQL 17 service
systemctl start postgresql@17-main

# Optionally, remove the old PostgreSQL 16 cluster
pg_dropcluster 16 main --stop