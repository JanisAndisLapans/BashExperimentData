gpg --keyserver keyserver.ubuntu.com --recv-keys EB4C1BFD4F04F6DDDCCEC917721F63BD38B4796 && 
gpg --verify data.tgz.asc data.tgz && echo "OK" || echo "FAIL"