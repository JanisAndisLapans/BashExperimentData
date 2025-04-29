{
  grep '^Exe' GHJ1.txt
  join -j 1 -o 0,1.2,1.3,2.2,2.3 <(sort GHJ1.txt) <(sort GHJ2.txt)
} | column -t