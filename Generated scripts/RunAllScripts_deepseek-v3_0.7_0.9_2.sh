for script in *.sh; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        if bash "$script"; then
            echo "${script}: OK"
        else
            echo "${script}: FAIL"
        fi
    else
        echo "${script}: SKIP (not executable or not a file)"
    fi
done
for script in *.sh; do
    if [ -f "$script" ] && [ ! -d "$script" ] && [ -x "$script" ]; then
        if bash "$script"; then
            echo "${script}: OK"
        else
            echo "${script}: FAIL"
        fi
    else
        echo "${script}: SKIP (not a regular executable file)"
    fi
done