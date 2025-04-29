#!/bin/bash

virtual_interfaces=$(ip -o link show | grep -E "veth|vlan|vxlan|tun|tap" | awk -F ': ' '{print $2}' | cut -d ' ' -f1)

if [ -z "$virtual_interfaces" ]; then
    echo "No virtual interfaces found"
else
    for interface in "$virtual_interfaces"; do
        ip_address=$(ip -4 addr show "$interface" | grep -oE "([0-9]{1,3}.){3}[0-9]{1,3}" | head -1)
        if [ -z "$ip_address" ]; then
            ip_address="None"
        fi
        echo "$interface - $ip_address"
    done
fi