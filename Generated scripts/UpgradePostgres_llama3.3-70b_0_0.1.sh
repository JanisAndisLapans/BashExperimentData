# Stop the PostgreSQL service
systemctl stop postgresql

# Install PostgreSQL 17
apt install postgresql-17

# Create a new data directory for PostgreSQL 17
mkdir /var/lib/postgresql/17/main
chown postgres:postgres /var/lib/postgresql/17/main

# Use pg_upgrade to upgrade the data
pg_upgrade -b /usr/lib/postgresql/16/bin -B /usr/lib/postgresql/17/bin \
           -d /var/lib/postgresql/16/main -D /var/lib/postgresql/17/main \
           -o ' -c config_file=/etc/postgresql/16/main/postgresql.conf' \
           -O ' -c config_file=/etc/postgresql/17/main/postgresql.conf'

# Remove the old PostgreSQL 16 data directory
rm -rf /var/lib/postgresql/16/main

# Update the PostgreSQL configuration files
mv /etc/postgresql/16/main/postgresql.conf /etc/postgresql/17/main/
mv /etc/postgresql/16/main/pg_hba.conf /etc/postgresql/17/main/
mv /etc/postgresql/16/main/pg_ident.conf /etc/postgresql/17/main/

# Start the PostgreSQL service
systemctl start postgresql