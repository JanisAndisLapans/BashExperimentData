lines_to_remove=5
total_lines=$(wc -l < data.md)
lines_to_keep=$((total_lines - lines_to_remove))

if [ $lines_to_keep -gt 0 ]; then
    head -n $lines_to_keep data.md > temp.md && mv temp.md data.md
else
    > data.md
fi