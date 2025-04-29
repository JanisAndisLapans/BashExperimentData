# Dump the MySQL database over a compressed SSH tunnel
ssh -C $1 "mysqldump -u TEST_USER -pTEST TEST_DB" | gzip > test_db_dump.sql.gz

# Transfer the compressed dump file back to local machine
scp $1:/path/to/test_db_dump.sql.gz /tmp/

# Import the dump file to local MySQL
gunzip < /tmp/test_db_dump.sql.gz | mysql -u TEST_USER -pTEST TEST_DB