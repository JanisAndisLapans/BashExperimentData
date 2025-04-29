awk -v FPAT='([^,]+)|(\"[^\"]+\")' '
NR==1 {
  for (i=1; i<=NF; i++) {
    if (tolower($i) == "price") {
      col = i
      break
    }
  }
}
NR > 1 {
  gsub(/[,"]/, "", $col)
  sum += $col
  count++
}
END {
  printf "Mean: %.2f\n", count ? sum/count : 0
}' products.csv