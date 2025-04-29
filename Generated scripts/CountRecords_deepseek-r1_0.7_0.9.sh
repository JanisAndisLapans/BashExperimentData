zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' '
    BEGIN { has=0; other=0 }
    {
        a2 = index($0, "apples=2")
        z2 = index($0, "Z=2")
        if (a2 && z2) has++
        if (!a2) other++
    }
    END { printf "Final counter value= %d ; other= %d\n", has, other }'