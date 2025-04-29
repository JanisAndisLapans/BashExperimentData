ip=$(ip -4 route show default | awk '{print $3}')
echo "IP: $ip"