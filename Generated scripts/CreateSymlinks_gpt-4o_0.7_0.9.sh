for file in /usr/src/*.java; do
  ln -s "$file" "$(basename "$file")"
done