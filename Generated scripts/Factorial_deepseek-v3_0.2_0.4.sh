#!/bin/bash

factorial() {
    local n=$1
    if (( n <= 1 )); then
        echo 1
    else
        echo $(( n * $(factorial $((n - 1))) ))
    fi
}

# Calculate factorial of 623
result=$(factorial 623)
echo "Factorial of 623 is: $result"
#!/bin/bash

echo "define f(n) { if (n <= 1) return 1; return n * f(n-1); } f(623)" | bc -l
python3 -c 'import math; print(math.factorial(623))'