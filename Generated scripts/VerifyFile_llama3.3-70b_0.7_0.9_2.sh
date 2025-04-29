gpg --keyserver keyserver.ubuntu.com --recv-keys "EB4C 1BFD 4F04 2F6D DDCC  EC91 7721 F63B D38B 4796" && 
gpg --verify data.tgz.asc data.tgz > /dev/null 2>&1 && echo "OK" || echo "FAIL"