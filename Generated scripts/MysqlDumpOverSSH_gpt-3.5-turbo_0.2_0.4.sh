# Dump the MySQL database over a compressed SSH tunnel
ssh -C $1 "mysqldump -u TEST_USER -pTEST TEST_DB" | gzip > test_db_dump.sql.gz

# Transfer the dump file back to the local machine
scp $1:test_db_dump.sql.gz .

# Import the dump file into another MySQL database
zcat test_db_dump.sql.gz | mysql -u TEST_USER -pTEST TEST_DB