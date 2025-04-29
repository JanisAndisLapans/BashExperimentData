if apt-get -s upgrade htop | grep -q "htop.*upgraded"; then
    echo "update needed"
else
    echo "update not needed"
fi