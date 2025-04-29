if apt-get -s upgrade htop | grep -q "^Inst"; then
    echo "update needed"
else
    echo "update not needed"
fi