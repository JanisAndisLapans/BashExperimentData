zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' '
BEGIN {
    cnt = 0
    other = 0
}
{
    a = 0
    z = 0
    split($0, lines, "\n")
    for (i in lines) {
        if (lines[i] == "apples=2") a = 1
        if (lines[i] == "Z=2") z = 1
    }
    if (a && z) cnt++
    if (!a) other++
}
END {
    print "Final counter value= " cnt " ; other= " other
}'