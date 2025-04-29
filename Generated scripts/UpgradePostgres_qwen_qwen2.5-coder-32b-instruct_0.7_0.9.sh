#!/bin/bash

# Stop the current PostgreSQL 16 cluster
pg_dropcluster 16 main --stop

# Install PostgreSQL 17
apt update
apt install postgresql-17

# Create a new PostgreSQL 17 cluster
pg_createcluster 17 main --start

# Upgrade the cluster from 16 to 17
pg_upgradecluster 16 main

# Drop the old PostgreSQL 16 cluster
pg_dropcluster 16 main

# Restart the PostgreSQL 17 cluster to ensure everything is working
systemctl restart postgresql