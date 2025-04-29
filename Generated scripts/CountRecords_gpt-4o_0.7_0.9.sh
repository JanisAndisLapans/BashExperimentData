zcat records.gz | awk -v RS='\\*\\*\\*\\*\n' '
{
  has_apples_2 = match($0, /apples=2/)
  has_z_2 = match($0, /Z=2/)
  if (has_apples_2 && has_z_2) {
    count_both++
  }
  if (!has_apples_2) {
    count_no_apples++
  }
}
END {
  printf "Final counter value= %d ; other= %d\n", count_both, count_no_apples
}
'