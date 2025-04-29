journalctl --since today --no-pager \
| grep -E 'Failed password|authentication failure|FAILED LOGIN' \
| awk '
    /Failed password for invalid user/ {
        for (i=1; i<=NF; i++) {
            if ($i == "invalid" && $(i+1) == "user") {
                print $(i+2);
                next;
            }
        }
    }
    /authentication failure/ && /user=/ {
        for (i=1; i<=NF; i++) {
            if ($i ~ /^user=/) {
                username = substr($i, 6);
                sub(/[^a-zA-Z0-9_].*/, "", username);
                print username;
                next;
            }
        }
    }
    /FAILED LOGIN/ {
        for (i=1; i<=NF; i++) {
            if ($i == "FOR") {
                username = $(i+1);
                gsub(/\x27|,/, "", username);
                print username;
                next;
            }
        }
    }' \
| sort | uniq -c \
| awk '$1 >=3 {count++} END {printf "Users: %d\n", count}'