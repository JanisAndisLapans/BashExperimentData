awk -F, '
BEGIN {
  col = 0
}
NR == 1 {
  for (i = 1; i <= NF; i++) {
    # Remove quotes and trim whitespace from header name
    gsub(/["]/, "", $i)
    header = tolower($i)
    sub(/^[ \t]+/, "", header)
    sub(/[ \t]+$/, "", header)
    if (header == "price") {
      col = i
      break
    }
  }
  if (col == 0) {
    print "Error: Column \"price\" not found"
    exit 1
  }
  next
}
{
  if ($col != "") {
    # Remove currency symbols, commas, and quotes from the value
    gsub(/["$£,]/, "", $col)
    sum += $col
    count++
  }
}
END {
  if (count > 0) {
    printf "Mean: %.2f\n", sum / count
  } else {
    print "No valid price data found"
  }
}' products.csv