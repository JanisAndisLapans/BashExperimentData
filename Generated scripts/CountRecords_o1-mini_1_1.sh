#!/bin/bash

zcat records.gz | awk '
BEGIN {
    RS="\\*\\*\\*\\*\n"
    has=0
    other=0
}
{
    if ($0 ~ /Z=2/ && $0 ~ /apples=2/) {
        has++
    }
    if ($0 !~ /apples=2/) {
        other++
    }
}
END {
    print "Final counter value= " has " ; other= " other
}
'