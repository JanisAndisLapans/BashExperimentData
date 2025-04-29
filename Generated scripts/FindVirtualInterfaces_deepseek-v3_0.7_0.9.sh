#!/bin/bash

# Get all virtual interfaces (excluding loopback)
virtual_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^veth|^docker|^virbr|^br-|^tun|^tap' | grep -v '^lo$')

if [[ -z "$virtual_interfaces" ]]; then
    echo "No virtual interfaces found"
    exit 0
fi

# Process each interface
while IFS= read -r interface; do
    # Get IPv4 address or set to None
    ipv4=$(ip -4 addr show dev "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "None")
    echo "${interface} - ${ipv4}"
done <<< "$virtual_interfaces"