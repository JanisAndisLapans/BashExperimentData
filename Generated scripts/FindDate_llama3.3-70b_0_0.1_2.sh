for i in {1..7}; do 
  DATE=$(date -d "2013-05-$i" +%Y-%m-%d); 
  if [ $(date -d "$DATE" +%u) -eq 1 ]; then 
    echo $DATE; 
    break; 
  fi; 
done