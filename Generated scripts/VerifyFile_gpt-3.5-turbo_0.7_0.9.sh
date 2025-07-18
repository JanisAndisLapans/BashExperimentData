#!/bin/bash

# Import the public key from keyserver.ubuntu.com
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796

# Verify the signature of the file
gpg --verify data.tgz.asc data.tgz 2>/dev/null

if [ $? -eq 0 ]; then
    echo "OK"
else
    echo "FAIL"
fi