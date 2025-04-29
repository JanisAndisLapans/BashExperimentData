#!/bin/bash

# Retrieve the public key from the keyserver
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F04F6DDDCCEC917721F63BD38B4796

# Verify the signature
if gpg --verify data.tgz.asc data.tgz &> /dev/null; then
  echo "OK"
else
  echo "FAIL"
fi