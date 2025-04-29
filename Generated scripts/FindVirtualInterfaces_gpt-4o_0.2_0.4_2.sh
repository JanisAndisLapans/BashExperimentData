#!/bin/bash

output=""
for iface in /sys/class/net/*; do
    iface=$(basename "$iface")
    if [[ "$iface" == "lo" || "$iface" == "eth"* || "$iface" == "wlan"* ]]; then
        continue
    fi
    ip=$(ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "None")
    output+="$iface - $ip"$'\n'
done

if [ -z "$output" ]; then
    echo "No virtual interfaces found"
else
    echo "$output"
fi