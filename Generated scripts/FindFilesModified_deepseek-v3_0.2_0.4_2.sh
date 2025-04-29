find /usr/info -maxdepth 1 -type f -mtime 21 -printf "%p\n"
find /usr/info -maxdepth 1 -type f -mtime +20 -mtime -22 -printf "%p\n"