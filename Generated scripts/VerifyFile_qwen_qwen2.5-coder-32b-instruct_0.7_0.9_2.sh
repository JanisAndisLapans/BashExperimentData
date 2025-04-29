gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCED917721F63BD38B4796
if gpg --list-keys EB4C1BFD4F042F6DDDCCED917721F63BD38B4796 > /dev/null 2>&1; then
    gpg --verify data.tgz.asc data.tgz && echo "OK" || echo "FAIL"
else
    echo "Key not found"
fi