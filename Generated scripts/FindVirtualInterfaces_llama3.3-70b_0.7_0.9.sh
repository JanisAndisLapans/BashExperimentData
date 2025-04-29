#!/bin/bash

virtual_interfaces=$(ip -o link show | grep -oE "^[0-9]+: ([^:]+):" | grep -v lo | awk '{print $2}' | grep -E "veth|vlan|vxlan")

if [ -z "$virtual_interfaces" ]; then
    echo "No virtual interfaces found"
else
    for interface in $virtual_interfaces; do
        ip_address=$(ip addr show $interface | grep -oE "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk '{print $2}')
        if [ -z "$ip_address" ]; then
            echo "$interface - None"
        else
            echo "$interface - $ip_address"
        fi
    done
fi