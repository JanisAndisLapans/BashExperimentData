strace -f -e execve ./exec.sh 2>&1 | grep execve | awk '{print $2}' | sed 's/[\(\)]//g' | tee child_processes.txt
ps -ef --forest | grep exec.sh | awk '{print $8}' > all_child_processes.txt
comm -12 <(sort child_processes.txt) <(sort all_child_processes.txt) > common_processes.txt
cat all_child_processes.txt