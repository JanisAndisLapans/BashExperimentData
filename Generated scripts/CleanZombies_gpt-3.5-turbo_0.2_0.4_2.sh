# Find all zombie processes
zombies=$(ps -eo pid,stat | awk '$2=="Z" {print $1}')

# Loop through each zombie process
for pid in $zombies; do
    # Find the parent process of the zombie
    parent_pid=$(ps -o ppid= -p $pid)

    # Kill the parent process of the zombie
    kill -KILL $parent_pid
done