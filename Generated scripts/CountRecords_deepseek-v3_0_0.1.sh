#!/bin/bash

# Initialize counters
count_both=0
count_no_apples=0

# Process the compressed file
zcat records.gz | awk -v RS='****\n' -v FS='\n' '
{
    has_z2 = 0
    has_apples2 = 0
    
    for (i=1; i<=NF; i++) {
        if ($i == "Z=2") has_z2 = 1
        if ($i == "apples=2") has_apples2 = 1
    }
    
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