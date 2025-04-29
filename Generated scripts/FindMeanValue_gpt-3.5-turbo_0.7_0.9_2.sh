mean=$(awk -F'[,;]' '{sum+=$2} END {print "Mean: " sum/NR}' "products.csv")
echo "$mean"