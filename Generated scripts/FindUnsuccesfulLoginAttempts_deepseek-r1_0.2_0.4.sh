grep "^$(date +"%b %e")" /var/log/auth.log \
| grep -E 'Failed password|authentication failure' \
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
    }' \
| sort | uniq -c \
| awk '$1 >=3 {count++} END {printf "Users: %d\n", count}'