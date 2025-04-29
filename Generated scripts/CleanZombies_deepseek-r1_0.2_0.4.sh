ps -e -o stat,pid,ppid --no-headers | \
    awk '$1 ~ /^Z/ && $3 != 1 {print $3}' | \
    sort -u | \
    xargs -r kill -9