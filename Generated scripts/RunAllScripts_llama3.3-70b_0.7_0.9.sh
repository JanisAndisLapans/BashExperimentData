for script in *.sh; do
  if bash "$script"; then
    echo "${script}: OK"
  else
    echo "${script}: FAIL"
  fi
done