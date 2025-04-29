#!/bin/bash
apt-get update
apt-get install -y postgresql-17
systemctl stop postgresql@17-main || true
pg_dropcluster 17 main --stop || true
systemctl stop postgresql@16-main
pg_upgradecluster -v 17 16 main
systemctl start postgresql@17-main
echo "Upgrade completed. Verify the new cluster and remove the old one with: pg_dropcluster 16 main --stop"