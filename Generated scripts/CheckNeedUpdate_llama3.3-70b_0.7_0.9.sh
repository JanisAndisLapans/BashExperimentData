if apt-get -s upgrade | grep -q "htop"; then
  echo "update needed"
else
  echo "update not needed"
fi