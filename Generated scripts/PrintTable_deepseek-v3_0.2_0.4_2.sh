#!/bin/bash

# Create associative arrays to store data from both files
declare -A file1_data
declare -A file2_data
exe_line=""

# Read GHJ1.txt and store data
while read -r line; do
    if [[ $line == Exe* ]]; then
        exe_line=$line
    else
        key=$(echo "$line" | awk '{print $1}')
        file1_data["$key"]=$(echo "$line" | awk '{$1=""; print substr($0,2)}')
    fi
done < GHJ1.txt

# Read GHJ2.txt and store data
while read -r line; do
    if [[ $line == Exe* ]]; then
        continue  # Skip Exe line in second file
    fi
    key=$(echo "$line" | awk '{print $1}')
    file2_data["$key"]=$(echo "$line" | awk '{$1=""; print substr($0,2)}')
done < GHJ2.txt

# Print the table header (Exe line from first file)
[[ -n "$exe_line" ]] && echo "$exe_line"

# Print merged data
# First print keys that exist in both files
for key in "${!file1_data[@]}"; do
    if [[ -n "${file2_data[$key]}" ]]; then
        echo "$key ${file1_data[$key]} ${file2_data[$key]}"
    fi
done

# Then print keys that only exist in file1
for key in "${!file1_data[@]}"; do
    if [[ -z "${file2_data[$key]}" ]]; then
        echo "$key ${file1_data[$key]}"
    fi
done

# Finally print keys that only exist in file2
for key in "${!file2_data[@]}"; do
    if [[ -z "${file1_data[$key]}" ]]; then
        echo "$key ${file2_data[$key]}"
    fi
done