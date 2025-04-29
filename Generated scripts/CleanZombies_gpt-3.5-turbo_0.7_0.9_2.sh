# Find all zombie processes and kill their direct parent process with SIGKILL
for pid in $(ps -eo pid,s | awk '$2=="Z" {print $1}'); do
    ppid=$(ps -p $pid -o ppid=)
    kill -KILL $ppid
done