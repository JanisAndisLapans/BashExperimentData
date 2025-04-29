# Stop the current PostgreSQL 16 cluster
pg_dropcluster 16 main

# Upgrade to PostgreSQL 17
pg_upgradecluster 16 main

# Start the PostgreSQL 17 cluster
pg_ctlcluster 17 main start