ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk '{print "IP: " $1}'
ip -4 addr | awk '/inet/ && !/127.0.0.1/ {split($2, a, "/"); print "IP: " a[1]; exit}'