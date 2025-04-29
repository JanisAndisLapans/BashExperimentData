#!/bin/bash

# Update package lists and install PostgreSQL 17
apt update
apt install -y postgresql-17

# Stop the current PostgreSQL 16 cluster
pg_dropcluster 16 main --stop

# Create a new PostgreSQL 17 cluster
pg_createcluster 17 main --start

# Upgrade the data from PostgreSQL 16 to PostgreSQL 17
pg_upgradecluster 16 main

# Verify the upgrade
pg_lsclusters

# Remove the old PostgreSQL 16 cluster
pg_dropcluster 16 main --stop