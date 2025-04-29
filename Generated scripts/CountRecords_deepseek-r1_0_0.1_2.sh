zcat records.gz | awk '
BEGIN {
    RS = "\\*\\*\\*\\*\n"
    cnt = 0
    other = 0
}
{
    a = 0
    z = 0
    split($0, lines, "\n")
    for (i in lines) {
        line = lines[i]
        sub(/^[[:space:]]+/, "", line)
        sub(/[[:space:]]+$/, "", line)
        if (line == "apples=2") a = 1
        if (line == "Z=2") z = 1
    }
    if (a && z) cnt++
    if (!a) other++
}
END {
    print "Final counter value= " cnt " ; other= " other
}'