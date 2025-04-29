{ echo -e "[client]\nuser=TEST_USER\npassword=TEST"; } > ~/.my.cnf.tmp
chmod 600 ~/.my.cnf.tmp
ssh -C "$1" "mysqldump --defaults-extra-file=/root/.my.cnf.tmp --no-tablespaces TEST_DB" 2> >(grep -v 'Using a password' >&2) | mysql --defaults-extra-file=/root/.my.cnf.tmp TEST_DB
rm ~/.my.cnf.tmp