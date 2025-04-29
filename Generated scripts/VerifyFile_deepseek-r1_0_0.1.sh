#!/bin/bash
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDDCEC917721F63BD38B4796 >/dev/null 2>&1
if gpg --verify data.tgz.asc data.tgz >/dev/null 2>&1; then
    echo "OK"
else
    echo "FAIL"
fi