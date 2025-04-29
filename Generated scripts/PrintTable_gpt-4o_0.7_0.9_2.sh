{
    grep '^Exe' GHJ1.txt GHJ2.txt
    join -j 1 GHJ1.txt GHJ2.txt
} | sort -k 1,1 -u | column -t