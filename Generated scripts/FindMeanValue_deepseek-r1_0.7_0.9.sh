awk -F',' '
NR == 1 {
    for (i = 1; i <= NF; i++) {
        if ($i == "price") {
            col = i
        }
    }
}
NR > 1 && $col != "" {
    gsub(/,/, "", $col)
    sum += $col
    count++
}
END {
    if (count) {
        printf "Mean: %.2f\n", sum/count
    } else {
        print "No valid price data found"
    }
}
' products.csv