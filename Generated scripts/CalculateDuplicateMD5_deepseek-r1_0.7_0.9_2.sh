find /usr/code -maxdepth 1 -type f -name '*.py' -exec md5sum {} + | sort | awk '
{
    arr[$1]=arr[$1] $2 "\n"
    count[$1]++
}
END {
    for (md5 in count) {
        if (count[md5] > 1) {
            printf "MD5: %s\nFiles:\n%s", md5, arr[md5]
        }
    }
}'