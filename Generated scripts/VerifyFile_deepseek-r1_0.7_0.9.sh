#!/bin/bash

# Check if required files exist
if [[ ! -f data.tgz || ! -f data.tgz.asc ]]; then
    echo "FAIL"
    exit 1
fi

# Create temporary GNUPG home
temp_dir=$(mktemp -d)
export GNUPGHOME="$temp_dir"

# Import key from keyserver
if ! gpg --batch --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796 &>/dev/null; then
    echo "FAIL"
    rm -rf "$temp_dir"
    exit 1
fi

# Verify signature and capture result
if gpg --batch --verify data.tgz.asc data.tgz &>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi

# Cleanup
rm -rf "$temp_dir"