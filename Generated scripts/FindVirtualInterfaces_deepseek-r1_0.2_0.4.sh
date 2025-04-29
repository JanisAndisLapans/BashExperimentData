#!/bin/bash

virtual_interfaces=$(ip -d link show | awk '
    BEGIN { RS=""; FS="\n" }
    {
        split($1, parts, ": ");
        iface = parts[2];
        sub(/:$/, "", iface);
        if (iface == "lo") next;
        is_virtual = 0;
        for (i = 1; i <= NF; i++) {
            if ($i ~ /bridge|tun|tap|veth|vlan|macvlan|ip6tnl|gre|sit/) {
                is_virtual = 1;
                break;
            }
        }
        if (is_virtual) print iface;
    }
')

if [[ -z "$virtual_interfaces" ]]; then
    echo "No virtual interfaces found"
    exit 0
fi

while read -r iface; do
    ipv4=$(ip -4 -br addr show dev "$iface" | awk '{gsub(/\/.*/,"",$3); print $3}')
    if [[ -z "$ipv4" ]]; then
        ipv4="None"
    fi
    echo "$iface - $ipv4"
done <<< "$virtual_interfaces"