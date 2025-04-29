ip=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
echo "IP: $ip"