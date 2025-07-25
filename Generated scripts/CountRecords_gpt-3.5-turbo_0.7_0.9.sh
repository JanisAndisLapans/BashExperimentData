# Count the number of times a record contains "Z=2" and "apples=2" and the number of records that don't have "apples=2"
z2_apples2_counter=0
no_apples2_counter=0

# Uncompress the file and use awk to count the occurrences
z2_apples2_counter=$(zcat records.gz | awk '/Z=2/ && /apples=2/ {count++} END {print count}')
no_apples2_counter=$(zcat records.gz | awk '!/apples=2/ {count++} END {print count}')

# Output the final count values
echo "Final counter value= {has apples=2 and Z=2} ; other= {doesn't have apples=2}"
echo "$z2_apples2_counter ; $no_apples2_counter"