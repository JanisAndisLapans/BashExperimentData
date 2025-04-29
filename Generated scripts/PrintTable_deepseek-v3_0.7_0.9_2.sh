#!/bin/bash

# Create associative arrays to store data from both files
declare -A file2_data
declare -a file1_order

# First read GHJ2.txt into an associative array
while IFS= read -r line; do
    if [[ -n $line ]]; then
        key=$(echo "$line" | awk '{print $1}')
        file2_data["$key"]="${line#* }"  # Store everything after first field
    fi
done < GHJ2.txt

# Then read GHJ1.txt, keeping order and processing matches
printf "%-10s %-15s %-15s %-15s\n" "Key" "GHJ1 Data" "GHJ2 Data" "Merged"
while IFS= read -r line; do
    if [[ -n $line ]]; then
        key=$(echo "$line" | awk '{print $1}')
        file1_order+=("$key")  # Maintain original order
        
        if [[ -n ${file2_data[$key]} ]]; then
            # Special case: Exe line should be first
            if [[ $key == "Exe"* ]]; then
                exe_line="$key ${line#* } ${file2_data[$key]}"
            else
                # Store other lines for later printing
                other_lines+=("$key ${line#* } ${file2_data[$key]}")
            fi
        fi
    fi
done < GHJ1.txt

# Print Exe line first if it exists
if [[ -n $exe_line ]]; then
    printf "%-10s %-15s %-15s %-15s\n" "Exe" "${exe_line%% *}" "${file2_data[Exe]}" "$exe_line"
fi

# Print other lines in original order
for line in "${other_lines[@]}"; do
    key=$(echo "$line" | awk '{print $1}')
    printf "%-10s %-15s %-15s %-15s\n" "$key" "${line#* }" "${file2_data[$key]}" "$line"
done