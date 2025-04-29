# Sort both files by the first field
sort -k1,1 GHJ1.txt -o GHJ1_sorted.txt
sort -k1,1 GHJ2.txt -o GHJ2_sorted.txt

# Perform a full outer join and merge matching lines
join -a1 -a2 GHJ1_sorted.txt GHJ2_sorted.txt > merged.txt

# Keep Exe lines at the start and preserve the rest of the order
{ grep '^Exe' merged.txt; grep -v '^Exe' merged.txt; } > final_table.txt

# Display the result in table format
column -t final_table.txt