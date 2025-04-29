find /usr/files -type f -exec md5sum {} + | sort | awk '{
    files[$1] = files[$1] ? files[$1] " " $2 : $2
} END {
    for (hash in files) {
        split(files[hash], arr, " ")
        if (length(arr) > 1) {
            print files[hash]
        }
    }
}'