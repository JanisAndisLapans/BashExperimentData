#!/bin/bash

# Dump the remote TEST_DB over a compressed SSH tunnel without tablespaces and import it into the local TEST_DB

ssh -C root@"$1" "mysqldump --no-tablespaces -u TEST_USER -p'TEST' TEST_DB" | mysql -u TEST_USER -p'TEST' TEST_DB