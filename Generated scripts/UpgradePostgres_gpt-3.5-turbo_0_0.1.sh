# Stop the current PostgreSQL cluster
systemctl stop postgresql

# Upgrade PostgreSQL to version 17
apt update
apt install postgresql-17

# Upgrade the cluster to version 17
pg_upgradecluster 16 main

# Start the new PostgreSQL 17 cluster
systemctl start postgresql@17-main