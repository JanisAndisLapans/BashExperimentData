#!/bin/bash
systemctl stop postgresql
apt update && apt install -y postgresql-17
# Remove automatically created new cluster if exists
if pg_lsclusters | grep -q '^17[[:space:]]*main'; then
    pg_dropcluster 17 main --stop
fi
pg_upgradecluster -v 17 16 main
systemctl start postgresql@17-main
pg_dropcluster 16 main --stop