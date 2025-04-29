#!/bin/bash

set -e

# Stop the PostgreSQL 16 service
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Initialize the new PostgreSQL 17 cluster
pg_createcluster 17 main --start

# Upgrade the data from the old cluster to the new one
pg_upgradecluster 16 main

# Verify the new cluster is running
if systemctl is-active --quiet postgresql@17-main; then
    echo "PostgreSQL 17 cluster is running."
else
    echo "PostgreSQL 17 cluster failed to start." >&2
    exit 1
fi

# If everything is working, remove the old PostgreSQL 16 cluster
pg_dropcluster 16 main --stop

echo "PostgreSQL upgrade from 16 to 17 completed successfully."