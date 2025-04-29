#!/bin/bash

# Get all network interfaces except loopback
interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$')

# Initialize a counter
count=0

for iface in $interfaces; do
    # Check if the interface is virtual by excluding common physical interface prefixes
    if [[ ! "$iface" =~ ^(eth|enp|wlan|wlp|ens|eno) ]]; then
        # Get IPv4 address
        ip_addr=$(ip -4 addr show "$iface" | awk '/inet /{print $2}' | cut -d'/' -f1)
        if [ -z "$ip_addr" ]; then
            ip_addr="None"
        fi
        echo "${iface} - ${ip_addr}"
        count=$((count + 1))
    fi
done

if [ $count -eq 0 ]; then
    echo "No virtual interfaces found"
fi