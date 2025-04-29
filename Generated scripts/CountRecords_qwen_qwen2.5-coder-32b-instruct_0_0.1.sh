zcat records.gz | awk -v RS='****\n' '
{
    has_apples2 = 0;
    has_Z2 = 0;
    for (i = 1; i <= NF; i++) {
        if ($i == "apples=2") has_apples2 = 1;
        if ($i == "Z=2") has_Z2 = 1;
    }
    if (has_apples2 && has_Z2) counter++;
    else if (!has_apples2) other++;
}
END {
    print "Final counter value= " counter " ; other= " other;
}'