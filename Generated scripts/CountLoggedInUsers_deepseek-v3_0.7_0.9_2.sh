users | wc -w
users | tr ' ' '\n' | sort -u | wc -l