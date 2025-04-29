#!/bin/bash

# Create associative arrays to store data from both files
declare -A file1_data
declare -A file2_data

# Read GHJ1.txt and store data (skip Exe line)
while read -r line; do
    if [[ $line == Exe* ]]; then
        exe_line=$line
    else
        key=$(echo "$line" | awk '{print $1}')
        file1_data["$key"]=$line
    fi
done < GHJ1.txt

# Read GHJ2.txt and store data
while read -r line; do
    key=$(echo "$line" | awk '{print $1}')
    file2_data["$key"]=$line
done < GHJ2.txt

# Print the table header (Exe line)
echo "$exe_line"

# Print merged data
for key in "${!file1_data[@]}"; do
    if [[ -n "${file2_data[$key]}" ]]; then
        # Merge lines when key exists in both files
        line1="${file1_data[$key]}"
        line2="${file2_data[$key]}"
        echo "$line1 $line2" | awk '{
            printf "%s ", $1; 
            for (i=2;i<=NF;i++) if ($i != $1) printf "%s ", $i; 
            print ""
        }' | sed 's/ $//'
    else
        # Just print line from file1 if no match in file2
        echo "${file1_data[$key]}"
    fi
done

# Print lines from file2 that weren't in file1
for key in "${!file2_data[@]}"; do
    if [[ -z "${file1_data[$key]}" ]]; then
        echo "${file2_data[$key]}"
    fi
done