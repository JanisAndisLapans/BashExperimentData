find /usr/files -type f -printf '%s %p\n' | sort -k1,1 | awk '{
    if ($1 == prev_size) {
        print $2
    } else {
        if (NR > 1) print ""
        printf "%s ", $2
    }
    prev_size = $1
}' | xargs -I{} -d '\n' sh -c '
    for file in "$@"; do
        md5sum "$file"
    done | sort | awk "{print \$2}" | uniq -d
' sh {} | while read -r file; do
    find /usr/files -type f -exec md5sum {} + | grep "$(md5sum "$file" | cut -d" " -f1)" | awk '{print $2}' | tr '\n' ' ' | sed 's/ $/\n/'
done