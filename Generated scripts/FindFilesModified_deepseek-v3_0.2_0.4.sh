find /usr/info -type f -mtime 21 -printf "%p\n"
find /usr/info -type f -mtime +20 -mtime -22 -printf "%p\n"