{
    grep '^Exe' GHJ1.txt
    grep '^Exe' GHJ2.txt
    join -j 1 GHJ1.txt GHJ2.txt
} | column -t