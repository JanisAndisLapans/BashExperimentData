zcat records.gz | awk -v RS='****\n' -v ORS='' '
    /Z=2/ && /apples=2/ {has_both++}
    !/apples=2/ {no_apples++}
    END {print "Final counter value= " has_both " ; other= " no_apples}
'