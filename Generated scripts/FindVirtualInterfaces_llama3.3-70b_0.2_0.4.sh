#!/bin/bash

virtual_interfaces=$(ip -o link show | grep -E "vir|vnet|tap" | awk -F': ' '{print $2}' | grep -v lo)

if [ -z "$virtual_interfaces" ]; then
    echo "No virtual interfaces found"
else
    for interface in $virtual_interfaces; do
        ip_address=$(ip -4 addr show $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
        if [ -z "$ip_address" ]; then
            ip_address="None"
        fi
        echo "$interface - $ip_address"
    done
fi