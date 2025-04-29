for script in ./*.sh; do
    if bash "$script"; then
        echo "$(basename "$script"): OK"
    else
        echo "$(basename "$script"): FAIL"
    fi
done