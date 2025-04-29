find /usr/code -maxdepth 1 -type f -name '*.py' -exec md5sum {} + | awk '
{
    md5=$1
    filename=$0
    sub(/^[^ ]*  /, "", filename)  # Properly remove MD5 and spaces to get filename
    if (md5 in count) {
        files[md5] = files[md5] "\n" filename
    } else {
        files[md5] = filename
    }
    count[md5]++
}
END {
    for (md5 in count) {
        if (count[md5] > 1) {
            printf "Duplicate MD5: %s\nFiles:\n%s\n\n", md5, files[md5]
        }
    }
}'