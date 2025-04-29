#!/bin/bash

interfaces=$(ip link show | grep 'state UP' | awk -F': ' '{print $2}' | grep -v 'lo')

if [ -z "$interfaces" ]; then
    echo "No virtual interfaces found"
else
    for interface in "$interfaces"; do
        ip_address=$(ip addr show "$interface" | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)
        if [ -z "$ip_address" ]; then
            ip_address="None"
        fi
        echo "$interface - $ip_address"
    done
fi