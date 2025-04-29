ssh $1 "mysqldump -h localhost -u TEST_USER -pTEST --single-transaction --quick TEST_DB" | gzip -c | gzip -dc | mysql -h localhost -u TEST_USER -pTEST TEST_DB
ssh $1 "mysqldump -h localhost -u TEST_USER --password=TEST --single-transaction --quick TEST_DB" | gzip -c | gzip -dc | mysql -h localhost -u TEST_USER --password=TEST TEST_DB
ssh $1 "mysqldump -h localhost --single-transaction --quick TEST_DB" | gzip -c | gzip -dc | mysql -h localhost TEST_DB
mysql -u root -pROOT_PASSWORD "GRANT PROCESS ON *.* TO 'TEST_USER'@'localhost'; FLUSH PRIVILEGES;"
[client]
user = TEST_USER
password = TEST