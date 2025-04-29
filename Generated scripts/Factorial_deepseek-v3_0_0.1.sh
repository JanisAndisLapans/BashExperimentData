#!/bin/bash

factorial() {
    local n=$1
    if (( n <= 1 )); then
        echo 1
    else
        echo $(( n * $(factorial $((n - 1))) ))
    fi
}

# Calculate factorial of 623 (note: this will hit recursion limits)
# For large numbers, better to use iterative approach or specialized tools
factorial_iterative() {
    local n=$1
    local result=1
    for (( i=1; i<=n; i++ )); do
        result=$((result * i))
    done
    echo $result
}

# For very large numbers like 623!, we should use bc
echo "define f(n) { if (n <= 1) return 1; return n * f(n-1); } f(623)" | bc