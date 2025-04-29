#!/bin/bash

# Initialize counters
count_both=0
count_no_apples=0

# Process the compressed file
zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' '
{
    has_z2 = 0
    has_apples2 = 0
    
    if ($0 ~ /\nZ=2(\n|$)/) has_z2 = 1
    if ($0 ~ /\napples=2(\n|$)/) has_apples2 = 1
    
    if (has_apples2 && has_z2) print "both"
    if (!has_apples2) print "no_apples"
}' | {
    while read -r result; do
        case $result in
            "both") ((count_both++)) ;;
            "no_apples") ((count_no_apples++)) ;;
        esac
    done
    
    echo "Final counter value= $count_both ; other= $count_no_apples"
}