{
  grep '^Exe' GHJ1.txt
  grep -v '^Exe' GHJ1.txt | awk '{print $1, $0}' > temp1.txt
  grep -v '^Exe' GHJ2.txt | awk '{print $1, $0}' > temp2.txt

  join -j 1 temp1.txt temp2.txt | awk '{$1=""; print $0}'
} | column -t

rm temp1.txt temp2.txt