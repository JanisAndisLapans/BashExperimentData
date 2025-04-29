#!/bin/bash

# Create associative arrays to store data from both files
declare -A file1_data
declare -A file2_data

# Read GHJ1.txt
while IFS= read -r line; do
    if [[ -n $line ]]; then
        key=$(echo "$line" | awk '{print $1}')
        file1_data["$key"]=$line
    fi
done < GHJ1.txt

# Read GHJ2.txt
while IFS= read -r line; do
    if [[ -n $line ]]; then
        key=$(echo "$line" | awk '{print $1}')
        file2_data["$key"]=$line
    fi
done < GHJ2.txt

# Print header
printf "%-20s %-20s %-20s %-20s\n" "Key" "GHJ1 Data" "GHJ2 Data" "Combined"

# Process and print matching lines
for key in "${!file1_data[@]}"; do
    if [[ -n ${file2_data[$key]} ]]; then
        # If line starts with "Exe", print it first
        if [[ $key == "Exe" ]]; then
            printf "%-20s %-20s %-20s %-20s\n" "$key" "${file1_data[$key]}" "${file2_data[$key]}" "${file1_data[$key]} ${file2_data[$key]#* }"
        fi
    fi
done

# Then print the rest
for key in "${!file1_data[@]}"; do
    if [[ -n ${file2_data[$key]} && $key != "Exe" ]]; then
        printf "%-20s %-20s %-20s %-20s\n" "$key" "${file1_data[$key]}" "${file2_data[$key]}" "${file1_data[$key]} ${file2_data[$key]#* }"
    fi
done