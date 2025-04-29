awk -F, '
BEGIN {
  col = 0
}
NR == 1 {
  for (i = 1; i <= NF; i++) {
    if ($i == "price") {
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
    gsub(/[$,]/, "", $col)
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