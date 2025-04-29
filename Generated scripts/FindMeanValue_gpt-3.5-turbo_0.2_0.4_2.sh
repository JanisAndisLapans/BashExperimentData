mean=$(awk -F ',' '{gsub(/[$,]/,"",$2); sum+=$2} END {print "Mean: " sum/NR}' "products.csv")
echo "$mean"