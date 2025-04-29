#!/bin/bash

# Get the PID of the exec.sh process (assuming only one instance is running)
parent_pid=$(pgrep -f 'exec.sh')

if [[ -z "$parent_pid" ]]; then
    echo "Error: exec.sh process not found"
    exit 1
fi

# Find all child processes recursively and filter for script files
pstree -p "$parent_pid" | grep -oP '([^/]+\.sh)(?=\))' | sort -u
#!/bin/bash

# Get the PID of the exec.sh process
parent_pid=$(pgrep -f 'exec.sh')

if [[ -z "$parent_pid" ]]; then
    echo "Error: exec.sh process not found"
    exit 1
fi

# Find all child processes and their command lines
ps -o pid= --ppid "$parent_pid" | while read -r pid; do
    ps -f --pid "$pid" | awk -v pid="$pid" '$2 == pid {print $8}'
done | grep '\.sh$' | sort -u