ifaces=$(ip -o -4 addr show | awk '$2 !~ /lo/ {print $2}')
if [[ -z $ifaces ]]; then
    echo "No virtual interfaces found"
else
    for iface in $ifaces; do
        ip=$(ip -o -4 addr show dev "$iface" | awk '{print $4}')
        if [[ -z $ip ]]; then
            ip="None"
        fi
        echo "$iface - $ip"
    done
fi