join -a1 -a2 -1 1 -2 1 <(sort -k1,1 GHJ1.txt) <(sort -k1,1 GHJ2.txt) | awk '
    $1 ~ /^Exe/ { exe[++n] = $0; next }
    { non_exe[++m] = $0 }
    END {
        for (i=1; i<=n; i++) print exe[i]
        for (i=1; i<=m; i++) print non_exe[i]
    }'