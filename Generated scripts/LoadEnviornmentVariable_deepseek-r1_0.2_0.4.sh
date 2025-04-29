USERNAME=$(grep -E '^USERNAME=' .env | cut -d= -f2- | sed -e 's/^["'\'' ]*//' -e 's/["'\'' ]*$//')
echo "$USERNAME"