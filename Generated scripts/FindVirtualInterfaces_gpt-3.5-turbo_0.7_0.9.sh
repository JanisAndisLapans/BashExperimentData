#!/bin/bash

# Check if there are any virtual interfaces (excluding loopback)
if [[ -n $(ip -o addr show | grep -v lo:) ]]; then
    # Loop through each interface (excluding loopback)
    ip -o addr show | grep -v lo: | while read -r line; do
        interface=$(echo $line | awk '{print $2}')
        ip=$(echo $line | awk '{print $4}')
        
        # Check if interface has an IPv4 address
        if [[ $ip == *"."* ]]; then
            echo "$interface - $ip"
        else
            echo "$interface - None"
        fi
    done
else
    echo "No virtual interfaces found"
fi