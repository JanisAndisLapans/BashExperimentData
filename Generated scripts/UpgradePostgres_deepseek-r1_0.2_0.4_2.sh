#!/bin/bash

# Add PostgreSQL repository for version 17 with proper variable expansion
echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Create key directory and import repository signing key properly
mkdir -p /etc/apt/keyrings
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg

# Install PostgreSQL 17 with client packages
apt-get update
apt-get install -y postgresql-17 postgresql-client-17

# Stop old cluster and upgrade with package validation
systemctl stop postgresql@16-main
pg_upgradecluster -v 17 16 main

# Remove old cluster after successful upgrade
pg_dropcluster 16 main --stop

# Optional: Set new cluster as default
systemctl enable postgresql@17-main