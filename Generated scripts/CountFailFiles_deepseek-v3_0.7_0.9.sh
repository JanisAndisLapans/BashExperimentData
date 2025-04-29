grep -rl --include="result.log" "FAIL" /usr/results | wc -l
grep -ril --include="result.log" "FAIL" /usr/results | wc -l