awk -F, '
  NR==1 {
    for(i=1; i<=NF; i++) {
      if ($i == "price") {
        col = i
        break
      }
    }
  }
  NR>1 {
    gsub(/,/, "", $col) # Remove commas for number formatting
    sum += $col
    count++
  }
  END {
    if(count > 0) {
      mean = sum / count
      printf "Mean: %.2f\n", mean
    } else {
      print "Mean: 0.00"
    }
  }
' products.csv