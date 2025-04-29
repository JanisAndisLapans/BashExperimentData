find /usr/files -type f -exec sha256sum {} + | sort | awk '
{
    hash = $1
    file = $2
    files[hash] = files[hash] " " file
}
END {
    for (h in files) {
        n = split(files[h], a, " ")
        if (n > 1) {
            print substr(files[h], 2)
        }
    }
}'