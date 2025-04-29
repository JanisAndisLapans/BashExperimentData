#!/bin/bash

# Stop the current PostgreSQL 16 cluster
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Create a new cluster for PostgreSQL 17
pg_createcluster 17 main --start

# Stop the new cluster to prepare for upgrade
systemctl stop postgresql@17-main

# Perform the upgrade using pg_upgradecluster
pg_upgradecluster -v 17 -m upgrade 16 main

# Remove the old cluster (after verifying the upgrade worked)
pg_dropcluster 16 main --stop

# Update symlinks to point to PostgreSQL 17
update-alternatives --auto pg_config
update-alternatives --auto pg_ctl
update-alternatives --auto postgresql

# Restart the new cluster
systemctl start postgresql@17-main

echo "PostgreSQL upgrade from 16 to 17 completed successfully"