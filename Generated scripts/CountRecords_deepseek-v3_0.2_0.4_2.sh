#!/bin/bash

# Initialize counters
count_both=0
count_no_apples=0

# Process the compressed file
while IFS= read -r record; do
    has_z2=0
    has_apples2=0
    
    # Split record into lines
    while IFS= read -r line; do
        [[ "$line" == "Z=2" ]] && has_z2=1
        [[ "$line" == "apples=2" ]] && has_apples2=1
    done <<< "$record"
    
    if (( has_apples2 && has_z2 )); then
        ((count_both++))
    elif (( !has_apples2 )); then
        ((count_no_apples++))
    fi
done < <(zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' 'NR>1{print prev} {prev=$0}')

echo "Final counter value= $count_both ; other= $count_no_apples"