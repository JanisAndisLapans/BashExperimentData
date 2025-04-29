#!/bin/bash
set -e

# Update package lists
apt update

# Install PostgreSQL 17
apt install -y postgresql-17

# Upgrade the 'main' cluster from version 16 to 17
pg_upgradecluster 16 main

# Optionally, remove the old PostgreSQL 16 packages if no longer needed
# apt remove -y postgresql-16