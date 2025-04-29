# Import the public key from the keyserver
gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796

# Verify the file against its signature
if gpg --verify data.tgz.asc data.tgz 2>/dev/null; then
    echo "OK"
else
    echo "FAIL"
fi