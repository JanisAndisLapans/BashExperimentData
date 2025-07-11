#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

# Update package lists
apt update

# Install PostgreSQL 17
apt install -y postgresql-17

# Upgrade the 'main' cluster from version 16 to 17
pg_upgradecluster 16 main

# Remove the old PostgreSQL 16 cluster
pg_dropcluster 16 main

# Optionally, remove the old PostgreSQL 16 packages if no longer needed
# apt remove -y postgresql-16