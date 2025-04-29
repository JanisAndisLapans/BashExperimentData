{
  grep '^Exe' GHJ1.txt
  grep -v '^Exe' GHJ1.txt GHJ2.txt | awk '
  {
    if (FILENAME == "GHJ1.txt") {
      data1[$1] = $0
    } else {
      data2[$1] = $0
    }
  }
  END {
    for (key in data1) {
      if (key in data2) {
        print data1[key], data2[key]
      } else {
        print data1[key]
      }
    }
    for (key in data2) {
      if (!(key in data1)) {
        print data2[key]
      }
    }
  }'
} | column -t