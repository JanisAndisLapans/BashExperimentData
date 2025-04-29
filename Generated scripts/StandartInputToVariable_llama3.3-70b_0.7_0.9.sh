text=$(dd bs=1 count=1 status=none; while IFS= read -r -n1 char; do
  if [ "$char" = "%" ]; then
    break
  fi
  printf "%s" "$char"
done)