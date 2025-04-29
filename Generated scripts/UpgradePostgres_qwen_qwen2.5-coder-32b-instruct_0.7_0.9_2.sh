#!/bin/bash

# Log file for the upgrade process
LOGFILE="/var/log/postgresql_upgrade.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Stop the current PostgreSQL 16 cluster
log_message "Stopping PostgreSQL 16 cluster..."
pg_dropcluster 16 main --stop
if [ $? -ne 0 ]; then
    log_message "Failed to stop PostgreSQL 16 cluster."
    exit 1
fi

# Install PostgreSQL 17
log_message "Updating package list..."
apt update >> $LOGFILE 2>&1
if [ $? -ne 0 ]; then
    log_message "Failed to update package list."
    exit 1
fi

log_message "Installing PostgreSQL 17..."
apt install -y postgresql-17 >> $LOGFILE 2>&1
if [ $? -ne 0 ]; then
    log_message "Failed to install PostgreSQL 17."
    exit 1
fi

# Create a new PostgreSQL 17 cluster
log_message "Creating new PostgreSQL 17 cluster..."
pg_createcluster 17 main --start
if [ $? -ne 0 ]; then
    log_message "Failed to create new PostgreSQL 17 cluster."
    exit 1
fi

# Upgrade the cluster from 16 to 17
log_message "Upgrading cluster from 16 to 17..."
pg_upgradecluster 16 main
if [ $? -ne 0 ]; then
    log_message "Failed to upgrade cluster from 16 to 17."
    exit 1
fi

# Drop the old PostgreSQL 16 cluster
log_message "Dropping old PostgreSQL 16 cluster..."
pg_dropcluster 16 main
if [ $? -ne 0 ]; then
    log_message "Failed to drop old PostgreSQL 16 cluster."
    exit 1
fi

# Restart the PostgreSQL 17 cluster to ensure everything is working
log_message "Restarting PostgreSQL 17 cluster..."
systemctl restart postgresql
if [ $? -ne 0 ]; then
    log_message "Failed to restart PostgreSQL 17 cluster."
    exit 1
fi

log_message "PostgreSQL upgrade from 16 to 17 completed successfully."