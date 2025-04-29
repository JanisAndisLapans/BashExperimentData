#!/bin/bash

# Stop the current PostgreSQL 16 service
systemctl stop postgresql

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Remove the automatically created PostgreSQL 17 cluster
pg_dropcluster 17 main --stop

# Create a new cluster for PostgreSQL 17
pg_createcluster 17 main --start

# Upgrade the existing cluster from 16 to 17
pg_upgradecluster 16 main

# Drop the old PostgreSQL 16 cluster
pg_dropcluster 16 main --stop

# Restart the PostgreSQL 17 service
systemctl restart postgresql

# Verify the upgrade
psql -c "SELECT version();"