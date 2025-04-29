#!/bin/bash

zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' -v FS='\n' '
BEGIN {
    count_both = 0
    count_no_apples = 0
}
{
    has_z2 = 0
    has_apples2 = 0
    for (i=1; i<=NF; i++) {
        if ($i ~ /^Z=2$/) has_z2 = 1
        if ($i ~ /^apples=2$/) has_apples2 = 1
    }
    if (has_z2 && has_apples2) count_both++
    if (!has_apples2) count_no_apples++
}
END {
    print "Final counter value= " count_both " ; other= " count_no_apples
}'