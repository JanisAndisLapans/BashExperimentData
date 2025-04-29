#!/bin/bash

# Stop the current PostgreSQL 16 cluster
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Create new cluster with same locale as old one
OLD_LOCALE=$(pg_lsclusters -h | grep "16/main" | awk '{print $6}')
pg_createcluster 17 main --locale="$OLD_LOCALE" --start

# Stop the new cluster to prepare for upgrade
systemctl stop postgresql@17-main

# Perform the upgrade using pg_upgradecluster
pg_upgradecluster -v 17 16 main

# Remove old cluster (after verifying new one works)
pg_dropcluster 16 main --stop

# Update default version to 17
update-alternatives --set pg_ctl /usr/lib/postgresql/17/bin/pg_ctl

# Start the new cluster
systemctl start postgresql@17-main

echo "PostgreSQL upgrade from 16 to 17 completed successfully"