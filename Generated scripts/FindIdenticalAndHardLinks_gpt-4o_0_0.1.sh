find /usr/files -type f -printf '%i %p\n' | sort -k1,1 | awk '{
    if ($1 == prev_inode) {
        printf "%s ", $2
    } else {
        if (NR > 1) print ""
        printf "%s ", $2
    }
    prev_inode = $1
} END { if (NR > 0) print "" }' | while read -r line; do
    files=($line)
    if [ ${#files[@]} -gt 1 ]; then
        echo "${files[@]}"
    fi
done