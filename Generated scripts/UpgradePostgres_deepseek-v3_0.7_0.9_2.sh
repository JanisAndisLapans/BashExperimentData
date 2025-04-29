#!/bin/bash

# Stop the current PostgreSQL 16 cluster
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt update
apt install -y postgresql-17

# Check if 17/main cluster already exists
if pg_lsclusters | grep -q '17/main'; then
    echo "Cluster 17/main already exists - removing it first"
    pg_dropcluster 17 main --stop
fi

# Create a new cluster for PostgreSQL 17 (temporarily)
pg_createcluster 17 main --start --port=5433

# Stop the new cluster to prepare for upgrade
systemctl stop postgresql@17-main

# Perform the upgrade using pg_upgradecluster
pg_upgradecluster -v 17 -m upgrade 16 main

# Verify the upgrade was successful before removing old cluster
if [ $? -eq 0 ]; then
    # Remove the old cluster
    pg_dropcluster 16 main --stop
    
    # Update default port back to 5432 if needed
    sed -i 's/port = 5433/port = 5432/' /etc/postgresql/17/main/postgresql.conf
    
    # Restart the new cluster
    systemctl restart postgresql@17-main
    
    # Update alternatives if they exist
    if [ -f /etc/alternatives/pg_config ]; then
        update-alternatives --auto pg_config
    fi
    if [ -f /etc/alternatives/pg_ctl ]; then
        update-alternatives --auto pg_ctl
    fi
    if [ -f /etc/alternatives/postgresql ]; then
        update-alternatives --auto postgresql
    fi
    
    echo "PostgreSQL upgrade from 16 to 17 completed successfully"
else
    echo "Upgrade failed - keeping PostgreSQL 16 cluster intact"
    systemctl start postgresql@16-main
fi
chmod +x upgrade_postgres.sh
./upgrade_postgres.sh