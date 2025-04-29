cd /usr/src
for file in *.java; do
    ln -s /usr/src/$file /path/to/current/directory/$file
done