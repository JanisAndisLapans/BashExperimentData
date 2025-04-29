awk '
FNR == NR {
    file1[$1] = substr($0, index($0, " ") + 1)
    next
}
{
    file2[$1] = substr($0, index($0, " ") + 1)
}
END {
    # Merge lines where key exists in both files
    for (key in file1) {
        if (key in file2) {
            merged[key] = key " " file1[key] " " file2[key]
        } else {
            merged[key] = key " " file1[key]
        }
    }
    # Add keys only in file2
    for (key in file2) {
        if (!(key in file1)) {
            merged[key] = key " " file2[key]
        }
    }
    # Print "Exe" lines first, then others
    PROCINFO["sorted_in"] = "@ind_str_asc"
    for (key in merged) {
        if (key ~ /^Exe/) print merged[key]
    }
    for (key in merged) {
        if (key !~ /^Exe/) print merged[key]
    }
}' GHJ1.txt GHJ2.txt