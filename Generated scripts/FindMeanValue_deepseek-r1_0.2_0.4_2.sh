awk -v FPAT='([^,]+)|(\"[^\"]+\")' '
BEGIN {
    col = 0
}
NR == 1 {
    for (i = 1; i <= NF; i++) {
        gsub(/^"|"$/, "", $i);
        if (tolower($i) == "price") {
            col = i;
            break;
        }
    }
    if (col == 0) {
        print "Error: Price column not found." > "/dev/stderr"
        exit 1
    }
}
NR > 1 {
    gsub(/[^0-9.]/, "", $col);
    if ($col != "") {
        sum += $col;
        count++;
    }
}
END {
    printf "Mean: %.2f\n", (count > 0) ? sum/count : 0
}' products.csv