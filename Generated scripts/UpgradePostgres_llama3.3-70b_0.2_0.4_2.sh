# Stop the PostgreSQL 16 service
systemctl stop postgresql@16-main

# Install PostgreSQL 17
apt install postgresql-17

# Create a new data directory for PostgreSQL 17
pg_ctlcluster 17 main init

# Use pg_upgrade to upgrade the data in link mode
pg_upgrade -b /usr/lib/postgresql/16/bin -B /usr/lib/postgresql/17/bin \
           -d /var/lib/postgresql/16/main -D /var/lib/postgresql/17/main \
           -o ' -c config_file=/etc/postgresql/16/main/postgresql.conf' \
           -O ' -c config_file=/etc/postgresql/17/main/postgresql.conf' \
           -l /var/log/postgresql/upgrade.log

# Remove the old PostgreSQL 16 data directory
rm -rf /var/lib/postgresql/16/main

# Start the PostgreSQL 17 service
systemctl start postgresql@17-main

# Enable the PostgreSQL 17 service to start at boot
systemctl enable postgresql@17-main