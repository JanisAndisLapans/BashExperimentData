#!/bin/bash

virtual_interfaces=$(ls -1 /sys/devices/virtual/net/ | grep -v '^lo$')

if [[ -z "$virtual_interfaces" ]]; then
    echo "No virtual interfaces found"
    exit 0
fi

while read -r iface; do
    if ip link show dev "$iface" >/dev/null 2>&1; then
        ipv4=$(ip -4 -br addr show dev "$iface" | awk '{gsub(/\/.*/,"",$3); print $3}')
        [[ -z "$ipv4" ]] && ipv4="None"
        echo "$iface - $ipv4"
    fi
done <<< "$virtual_interfaces"