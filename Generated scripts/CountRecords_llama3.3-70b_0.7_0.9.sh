#!/bin/bash

has_both=0
doesnt_have_apples=0

zcat records.gz | awk -v RS='****\n' -v ORS='' '
    { 
        if (/Z=2/ && /apples=2/) { 
            has_both++ 
        } 
        if (!/apples=2/) { 
            doesnt_have_apples++ 
        } 
    } 
    END { 
        print "Final counter value=" has_both " ; other=" doesnt_have_apples 
    }'