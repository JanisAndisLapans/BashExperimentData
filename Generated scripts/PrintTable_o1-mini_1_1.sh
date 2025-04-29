join -j1 <(sort -k1,1 GHJ1.txt) <(sort -k1,1 GHJ2.txt) | \
awk '{ if ($1 ~ /^Exe/) print "1 " $0; else print "2 " $0 }' | \
sort -n | cut -d' ' -f2- | column -t