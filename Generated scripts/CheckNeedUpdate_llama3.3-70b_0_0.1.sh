if [ $(apt-get -s upgrade htop | grep -c "htop") -gt 0 ]; then
  echo "update needed"
else
  echo "update not needed"
fi