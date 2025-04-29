#!/bin/bash

virtual_interfaces=$(ip -j -d link show | jq -r '.[] | select(.ifname != "lo" and (.linkinfo.info_kind? // "" | test("^(veth|bridge|tun|tap)$"))) | .ifname')

if [[ -z "$virtual_interfaces" ]]; then
    echo "No virtual interfaces found"
else
    while IFS= read -r iface; do
        ipv4=$(ip -j addr show "$iface" | jq -r '.[0].addr_info | [.[] | select(.family == "inet").local] | if length == 0 then "None" else join(", ") end')
        echo "$iface - $ipv4"
    done <<< "$virtual_interfaces"
fi