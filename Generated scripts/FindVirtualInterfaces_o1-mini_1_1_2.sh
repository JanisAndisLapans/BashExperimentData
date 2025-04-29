#!/bin/bash

# Function to check if an interface is virtual
is_virtual() {
    local iface="$1"
    # Check if interface has a physical driver
    if ethtool -i "$iface" &>/dev/null; then
        return 1  # Physical
    else
        return 0  # Virtual
    fi
}

# Get all interfaces except loopback
interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$')

# Initialize a counter
count=0

for iface in $interfaces; do
    if is_virtual "$iface"; then
        # Get IPv4 address
        ip_addr=$(ip -4 addr show "$iface" | awk '/inet / {print $2}' | cut -d'/' -f1)
        if [ -z "$ip_addr" ]; then
            ip_addr="None"
        fi
        echo "${iface} - ${ip_addr}"
        count=$((count + 1))
    fi
done

if [ $count -eq 0 ]; then
    echo "No virtual interfaces found"
fi