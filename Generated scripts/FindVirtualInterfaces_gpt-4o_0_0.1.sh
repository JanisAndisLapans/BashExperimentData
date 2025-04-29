#!/bin/bash

output=""
for iface in $(ls /sys/class/net/ | grep -v lo); do
    ip=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "None")
    if [[ $ip != "None" ]]; then
        output+="$iface - $ip"$'\n'
    fi
done

if [[ -z $output ]]; then
    echo "No virtual interfaces found"
else
    echo "$output"
fi