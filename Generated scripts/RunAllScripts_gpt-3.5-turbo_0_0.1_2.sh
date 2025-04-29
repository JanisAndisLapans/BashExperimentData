for script in *.sh; do
    if [ -x "$script" ]; then
        if ./"$script"; then
            echo "$script: OK"
        else
            echo "$script: FAIL"
        fi
    fi
done