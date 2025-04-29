awk '
BEGIN {
    print "Exe"
}
NR==FNR {
    if ($1 == "Exe") next
    a[$1] = $0
    next
}
{
    if ($1 in a) {
        print a[$1], $2, $3, $4
        delete a[$1]
    } else {
        print $0
    }
}
END {
    for (left in a) print a[left]
}
' GHJ1.txt GHJ2.txt | column -t -s' ' | sed '/^Exe$/d;1i Exe'