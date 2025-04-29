#!/bin/bash

# Create associative arrays to store data from both files
declare -A file1_data
declare -A file2_data

# Read GHJ1.txt
while IFS=' ' read -r key rest; do
    file1_data["$key"]="$rest"
done < GHJ1.txt

# Read GHJ2.txt
while IFS=' ' read -r key rest; do
    file2_data["$key"]="$rest"
done < GHJ2.txt

# Print header
printf "%-20s %-20s %-20s\n" "Key" "GHJ1 Data" "GHJ2 Data"
echo "--------------------------------------------------------"

# First print the "Exe" line if it exists in either file
if [[ -n "${file1_data[Exe]}" || -n "${file2_data[Exe]}" ]]; then
    printf "%-20s %-20s %-20s\n" "Exe" "${file1_data[Exe]}" "${file2_data[Exe]}"
fi

# Print all other keys (excluding Exe)
for key in "${!file1_data[@]}" "${!file2_data[@]}"; do
    if [[ "$key" != "Exe" ]]; then
        printf "%-20s %-20s %-20s\n" "$key" "${file1_data[$key]}" "${file2_data[$key]}"
    fi
done | sort -u