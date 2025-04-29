find /usr/code -type f -name '*.py' -exec md5sum {} + | awk '{
    md5=$1
    filename=substr($0, 35)
    if (count[md5]++) {
        files[md5] = files[md5] "\n" filename
    } else {
        files[md5] = filename
    }
}
END {
    for (md5 in count) {
        if (count[md5] > 1) {
            printf "Duplicate MD5: %s\nFiles:\n%s\n\n", md5, files[md5]
        }
    }
}'