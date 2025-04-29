ls -l | grep -E '^-r'
ls -l | awk '$1 ~ /^-.r/'