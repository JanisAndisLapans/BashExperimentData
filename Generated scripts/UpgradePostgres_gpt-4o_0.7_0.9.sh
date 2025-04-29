# Stop the PostgreSQL 16 service
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install postgresql-17

# Initialize the new PostgreSQL 17 cluster
pg_createcluster 17 main --start

# Upgrade the data from the old cluster to the new one
pg_upgradecluster 16 main

# Check the status of the new PostgreSQL 17 cluster
systemctl status postgresql@17-main

# If everything is working, you can remove the old PostgreSQL 16 cluster
pg_dropcluster 16 main --stop