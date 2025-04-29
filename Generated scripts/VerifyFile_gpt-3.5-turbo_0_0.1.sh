gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796
gpg --verify data.tgz.asc data.tgz 2>/dev/null | grep -q "Good signature" && echo "OK" || echo "FAIL"