#!/bin/bash

# Calculate factorial using bc for arbitrary precision
echo "define f(x) { if (x <= 1) return (1); return (x * f(x-1)); } f(623);" | bc
#!/bin/bash

fact=1
for ((i=1; i<=623; i++)); do
    fact=$(echo "$fact * $i" | bc)
done
echo "$fact"