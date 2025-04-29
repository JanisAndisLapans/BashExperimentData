#!/bin/bash

# Get all non-physical interfaces (excluding loopback)
virtual_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | while read -r iface; do
    if [[ "$iface" != "lo" ]] && ! [[ -d "/sys/class/net/$iface/device" ]]; then
        echo "$iface"
    fi
done)

if [[ -z "$virtual_interfaces" ]]; then
    echo "No virtual interfaces found"
    exit 0
fi

# Process each interface
while IFS= read -r interface; do
    # Get IPv4 address or set to None
    ipv4=$(ip -4 addr show dev "$interface" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "None")
    echo "${interface} - ${ipv4}"
done <<< "$virtual_interfaces"