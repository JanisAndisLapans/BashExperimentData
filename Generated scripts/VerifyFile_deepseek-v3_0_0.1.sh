#!/bin/bash

# Import the public key from the keyserver
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796

# Verify the signature and capture the output
if gpg --verify data.tgz.asc data.tgz 2>&1 | grep -q "Good signature"; then
    echo "OK"
else
    echo "FAIL"
fi