#!/bin/bash

found=0

for interface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$'); do
    # Check if it's a virtual interface (either by name or by flags)
    if [[ "$interface" =~ ^(veth|virbr|docker|br-|tun|tap|vnet|vmnet)[a-zA-Z0-9]* ]] || \
       [[ $(ip -d link show dev "$interface" | grep -c "link/ether") -eq 0 ]]; then
        ipv4=$(ip -4 addr show dev "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
        if [ -z "$ipv4" ]; then
            ipv4="None"
        fi
        echo "$interface - $ipv4"
        found=1
    fi
done

if [ "$found" -eq 0 ]; then
    echo "No virtual interfaces found"
fi