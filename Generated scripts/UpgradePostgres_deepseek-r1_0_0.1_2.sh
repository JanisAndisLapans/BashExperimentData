#!/bin/bash
apt-get update
apt-get install -y postgresql-17

# Stop both clusters to prevent conflicts
systemctl stop postgresql@16-main || true
systemctl stop postgresql@17-main || true

# Upgrade the cluster
pg_upgradecluster -v 17 16 main

# Ensure new cluster is running
systemctl start postgresql@17-main

# Clean up old cluster (now with proper existence check)
if pg_lsclusters | grep -q '16 main'; then
    systemctl stop postgresql@16-main
    pg_dropcluster 16 main --stop
fi

echo "Upgrade completed. Old cluster 16-main has been removed."