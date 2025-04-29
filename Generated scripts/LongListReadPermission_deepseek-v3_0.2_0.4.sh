ls -l | grep -E '^-r'
find . -maxdepth 1 -type f -perm -u=r -ls