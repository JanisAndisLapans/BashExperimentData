users | tr ' ' '\n' | sort -u | wc -l
who | awk '{print $1}' | sort -u | wc -l