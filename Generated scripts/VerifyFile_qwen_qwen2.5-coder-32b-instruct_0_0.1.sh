gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCED917721F63BD38B4796
gpg --verify data.tgz.asc data.tgz && echo "OK" || echo "FAIL"