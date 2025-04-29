awk -F, '
  NR==1 {
    for(i=1; i<=NF; i++) {
      if (tolower($i) == "price") {
        col = i
        break
      }
    }
    if (!col) {
      print "Mean: 0.00"
      exit
    }
  }
  NR>1 && col {
    # Remove any commas and quotes
    gsub(/[",]/, "", $col)
    # Replace comma decimal separators with dots if necessary
    gsub(/,/, ".", $col)
    if ($col ~ /^[0-9.]+$/) {
      sum += $col
      count++
    }
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