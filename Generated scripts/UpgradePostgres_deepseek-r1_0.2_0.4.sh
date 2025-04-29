#!/bin/bash

# Add PostgreSQL repository for version 17
echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main' > /etc/apt/sources.list.d/pgdg.list

# Import repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install PostgreSQL 17
apt-get update
apt-get install -y postgresql-17

# Stop old cluster and upgrade
systemctl stop postgresql@16-main
pg_upgradecluster -v 17 16 main

# Remove old cluster
pg_dropcluster 16 main --stop