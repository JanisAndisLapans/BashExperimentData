zcat records.gz | awk -v RS='****\n' -v ORS='' '
    $0 ~ /Z=2/ && $0 ~ /apples=2/ {has_both++}
    $0 !~ /apples=2/ {no_apples++}
    END {print "Final counter value= " has_both " ; other= " no_apples}
'