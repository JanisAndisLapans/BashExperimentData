#!/bin/bash

# Import the public key if not already present
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796 &>/dev/null

# Verify the signature and capture output
if gpg --verify data.tgz.asc data.tgz &>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi