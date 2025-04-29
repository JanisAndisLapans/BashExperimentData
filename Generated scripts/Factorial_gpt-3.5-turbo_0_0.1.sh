factorial=1
for (( i=1; i<=623; i++ )); do
    factorial=$((factorial * i))
done
echo $factorial