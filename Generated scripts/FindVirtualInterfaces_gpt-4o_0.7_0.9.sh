#!/bin/bash

output=""
interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v 'lo')

for iface in $interfaces; do
    if [[ $iface == veth* ]] || [[ $iface == br-* ]] || [[ $iface == docker* ]] || [[ $iface == virbr* ]]; then
        ip=$(ip -o -4 addr show $iface | awk '{print $4}' | cut -d/ -f1)
        if [ -z "$ip" ]; then
            ip="None"
        fi
        output+="${iface} - ${ip}\n"
    fi
done

if [ -z "$output" ]; then
    echo "No virtual interfaces found"
else
    echo -e "$output"
fi