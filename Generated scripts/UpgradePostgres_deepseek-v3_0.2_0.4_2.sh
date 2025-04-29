#!/bin/bash

# Stop the current PostgreSQL 16 cluster
systemctl stop postgresql@16-main

# Install PostgreSQL 17
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y postgresql-17

# Check if 17/main cluster already exists
if pg_lsclusters | grep -q '^17.*main'; then
    echo "Cluster 17/main already exists - removing it first"
    pg_dropcluster 17 main --stop
fi

# Perform the upgrade using pg_upgradecluster with --rename-conflicting option
pg_upgradecluster -v 17 16 main --rename-conflicting

# Verify the upgrade was successful
if sudo -u postgres psql -c "SELECT version();" | grep -q 'PostgreSQL 17'; then
    # Remove the old cluster after successful upgrade
    pg_dropcluster 16 main --stop
    
    # Start the new PostgreSQL 17 cluster
    systemctl start postgresql@17-main
    
    echo "Upgrade completed successfully"
    sudo -u postgres psql -c "SELECT version();"
else
    echo "Upgrade failed - keeping old cluster"
    systemctl start postgresql@16-main
fi