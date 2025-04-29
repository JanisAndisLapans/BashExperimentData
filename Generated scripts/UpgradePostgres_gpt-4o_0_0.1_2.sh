# Stop both PostgreSQL 16 and 17 services
systemctl stop postgresql@16-main
systemctl stop postgresql@17-main

# Remove the existing PostgreSQL 17 cluster to avoid conflicts
pg_dropcluster 17 main --stop

# Recreate the PostgreSQL 17 cluster
pg_createcluster 17 main

# Upgrade the data from PostgreSQL 16 to 17
pg_upgradecluster 16 main

# Start the PostgreSQL 17 service
systemctl start postgresql@17-main

# Verify the upgrade by checking the status of the new cluster
pg_lsclusters

# Optionally, remove the old PostgreSQL 16 cluster if everything is working fine
pg_dropcluster 16 main --stop