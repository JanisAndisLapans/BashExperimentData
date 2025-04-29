for script in *.sh; do
  if [ -f "$script" ]; then
    if bash "$script" &>/dev/null; then
      echo "${script}: OK"
    else
      echo "${script}: FAIL"
    fi
  fi
done