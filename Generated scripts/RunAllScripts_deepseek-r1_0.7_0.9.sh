for script in *.sh; do
  if [[ -f "$script" ]]; then
    bash "$script" &>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "${script}: OK"
    else
      echo "${script}: FAIL"
    fi
  fi
done