#!/bin/bash

has_both=0
doesnt_have_apples=0

zcat records.gz | awk -v RS='****\n' '
    { 
        if ($0 ~ /Z=2/ && $0 ~ /apples=2/) { 
            has_both++ 
        } 
        if (!$0 ~ /apples=2/) { 
            doesnt_have_apples++ 
        } 
    } 
    END { 
        printf "Final counter value=%d ; other=%d\n", has_both, doesnt_have_apples 
    }'