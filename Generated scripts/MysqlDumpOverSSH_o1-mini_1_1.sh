#!/bin/bash

# Dump the remote TEST_DB over a compressed SSH tunnel and import it into the local TEST_DB

ssh -C root@"$1" "mysqldump -u TEST_USER -p'TEST' TEST_DB" | mysql -u TEST_USER -p'TEST' TEST_DB