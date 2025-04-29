#!/bin/bash

found=0

while read -r iface; do
    if [[ "$iface" == "lo" ]]; then
        continue
    fi
    if ip -d link show "$iface" 2>/dev/null | grep -q -e 'veth' -e 'bridge' -e 'tun' -e 'tap' -e 'vlan' -e 'bond' -e 'macvlan'; then
        found=1
        ipv4=$(ip -4 addr show dev "$iface" | awk '/inet / {print $2}' | cut -d/ -f1)
        echo "$iface - ${ipv4:-None}"
    fi
done < <(ip -o link show | awk -F': ' '{print $2}')

if [[ "$found" -eq 0 ]]; then
    echo "No virtual interfaces found"
fi