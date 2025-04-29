find /usr/files -type f -print0 | xargs -0 md5sum | sort | awk '{
    if (seen[$1]++) {
        printf("%s %s\n", prev, $2)
    } else {
        prev = $2
    }
}' | sort -u