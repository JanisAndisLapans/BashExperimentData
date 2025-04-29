z_and_apples_counter=0
no_apples_counter=0

# Count the number of records that contain both "Z=2" and "apples=2"
z_and_apples_counter=$(zcat records.gz | awk 'BEGIN{RS="****\n"} /Z=2/ && /apples=2/ {count++} END{print count}')

# Count the number of records that do not contain "apples=2"
no_apples_counter=$(zcat records.gz | awk 'BEGIN{RS="****\n"} !/apples=2/ {count++} END{print count}')

echo "Final counter value= {has apples=2 and Z=2} ; other= {doesn't have apples=2}"
echo "Final counter value= $z_and_apples_counter ; other= $no_apples_counter"