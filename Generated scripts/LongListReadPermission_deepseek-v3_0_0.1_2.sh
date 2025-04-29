find . -maxdepth 1 -type f -perm -u=r -ls
find . -maxdepth 1 -type f -perm -u=r -exec ls -ld {} +