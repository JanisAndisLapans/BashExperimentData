grep -rl "FAIL" /usr/results --include="result.log" | wc -l
grep -ril "FAIL" /usr/results --include="result.log" | wc -l