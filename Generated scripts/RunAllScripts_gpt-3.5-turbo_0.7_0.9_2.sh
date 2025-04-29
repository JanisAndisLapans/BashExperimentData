for script in *.sh; do
    ./"$script" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$script: OK"
    else
        echo "$script: FAIL"
    fi
done