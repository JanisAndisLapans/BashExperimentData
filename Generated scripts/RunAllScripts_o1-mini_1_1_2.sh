for script in ./*.sh; do
    if [ -f "$script" ]; then
        if bash "$script"; then
            echo "$(basename "$script"): OK"
        else
            echo "$(basename "$script"): FAIL"
        fi
    else
        echo "$(basename "$script"): FAIL"
    fi
done