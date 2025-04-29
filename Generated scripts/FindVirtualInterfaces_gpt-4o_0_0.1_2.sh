#!/bin/bash

output=""
found=false

for iface in /sys/class/net/*; do
    iface=$(basename "$iface")
    if [[ "$iface" != "lo" ]]; then
        ip=$(ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "None")
        if [[ $ip != "None" ]]; then
            output+="$iface - $ip"$'\n'
            found=true
        fi
    fi
done

if ! $found; then
    echo "No virtual interfaces found"
else
    echo "$output"
fi