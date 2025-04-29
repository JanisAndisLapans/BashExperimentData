shopt -s nullglob
for file in /usr/src/*.java; do
    ln -sf "$file" "./$(basename "$file")"
done
shopt -u nullglob