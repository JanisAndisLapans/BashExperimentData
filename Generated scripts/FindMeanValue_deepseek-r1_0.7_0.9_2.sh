awk -F',' '
NR == 1 {
    for (i = 1; i <= NF; i++) {
        if ($i == "price" || $i == "\"price\"") {
            col = i
        }
    }
}
NR > 1 {
    if ($col != "") {
        # Remove all non-numeric characters except decimal point
        gsub(/[^0-9.]/, "", $col)
        # Handle empty strings after cleanup
        if ($col != "") {
            sum += $col
            count++
        }
    }
}
END {
    if (count) {
        printf "Mean: %.2f\n", sum/count
    } else {
        print "No valid price data found"
    }
}
' products.csv