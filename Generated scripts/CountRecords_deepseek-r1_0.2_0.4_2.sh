zcat records.gz | awk '
    BEGIN {
        RS = "\\*\\*\\*\\*\n"  # Properly escaped record separator
        main = 0
        other = 0
    }
    {
        has_apples = ($0 ~ /apples=2/)
        has_z = ($0 ~ /Z=2/)
        if (has_apples && has_z) main++
        if (!has_apples) other++
    }
    END {
        printf "Final counter value= %d ; other= %d\n", main, other
    }'