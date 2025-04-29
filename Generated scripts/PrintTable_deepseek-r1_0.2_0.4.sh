awk '
FNR == NR {
    key = $1
    rest = substr($0, index($0, " ") + 1)
    if (key in merged) {
        merged[key] = merged[key] " " rest
    } else {
        merged[key] = $0
    }
    next
}
{
    key = $1
    rest = substr($0, index($0, " ") + 1)
    if (key in merged) {
        merged[key] = merged[key] " " rest
    } else {
        merged[key] = $0
    }
}
END {
    # Print lines starting with "Exe" first
    for (key in merged) {
        if (key ~ /^Exe/) {
            print merged[key]
            delete merged[key]
        }
    }
    # Print remaining lines
    for (key in merged) {
        print merged[key]
    }
}' GHJ1.txt GHJ2.txt