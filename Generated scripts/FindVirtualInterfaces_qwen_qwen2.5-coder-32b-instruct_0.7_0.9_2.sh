interfaces=$(ip -o link show | grep -E 'state UP' | awk -F': ' '{print $2}' | grep -v 'lo')
if [ -z "$interfaces" ]; then
    echo "No virtual interfaces found"
else
    for interface in "$interfaces"; do
        ip=$(ip -4 addr show "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
        echo "${interface} - ${ip:-None}"
    done
fi