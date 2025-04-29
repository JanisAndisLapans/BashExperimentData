awk '
BEGIN {
    print "Exe"
}
NR==FNR {
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
    for (left in a) {
        print a[left]
    }
}
' GHJ1.txt GHJ2.txt | column -t