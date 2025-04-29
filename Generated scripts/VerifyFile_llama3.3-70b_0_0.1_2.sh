#!/bin/bash

# Retrieve the public key from the keyserver
gpg --keyserver keyserver.ubuntu.com --recv-keys "EB4C 1BFD 4F04 2F6D DDCC  EC91 7721 F63B D38B 4796"

# Verify the signature
if gpg --verify data.tgz.asc data.tgz &> /dev/null; then
  echo "OK"
else
  echo "FAIL"
fi