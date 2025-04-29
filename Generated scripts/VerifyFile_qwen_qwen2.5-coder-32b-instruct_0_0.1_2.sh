# Fetch the key again
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCED917721F63BD38B4796

# Verify the signature
if gpg --verify data.tgz.asc data.tgz 2>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi
# Assuming you have the key in a file named key.asc
gpg --import key.asc

# Verify the signature
if gpg --verify data.tgz.asc data.tgz 2>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi
# Try a different keyserver
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCED917721F63BD38B4796

# Verify the signature
if gpg --verify data.tgz.asc data.tgz 2>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi