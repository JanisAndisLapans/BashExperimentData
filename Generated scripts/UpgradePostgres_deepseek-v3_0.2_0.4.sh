#!/bin/bash

# Stop the current PostgreSQL 16 cluster
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Create new cluster with same name (main) for PostgreSQL 17
pg_createcluster 17 main --start

# Stop the new cluster to perform the upgrade
systemctl stop postgresql@17-main

# Perform the upgrade using pg_upgradecluster
pg_upgradecluster -v 17 16 main

# Remove the old cluster (after verifying the upgrade worked)
pg_dropcluster 16 main --stop

# Update any configuration files if needed (like pg_hba.conf, postgresql.conf)
# The new cluster will have default configs, you may want to merge your customizations
# from /etc/postgresql/16/main/ to /etc/postgresql/17/main/

# Start the new PostgreSQL 17 cluster
systemctl start postgresql@17-main

# Verify the upgrade was successful
sudo -u postgres psql -c "SELECT version();"