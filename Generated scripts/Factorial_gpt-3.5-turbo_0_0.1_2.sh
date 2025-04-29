factorial=1
for (( i=1; i<=623; i++ )); do
    factorial=$(echo "$factorial * $i" | bc)
done
echo $factorial