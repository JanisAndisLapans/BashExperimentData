for script in *.sh; do
    if [ -x "$script" ]; then
        ./"$script" && echo "$script: OK" || echo "$script: FAIL"
    fi
done