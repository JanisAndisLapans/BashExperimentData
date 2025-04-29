for script in *.sh; do
    chmod +x "$script"
    if ./"$script"; then
        echo "$script: OK"
    else
        echo "$script: FAIL"
    fi
done