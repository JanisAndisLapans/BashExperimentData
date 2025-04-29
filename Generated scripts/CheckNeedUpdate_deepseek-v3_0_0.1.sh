if apt-get -s upgrade htop | grep -q "Inst htop"; then
    echo "update needed"
else
    echo "update not needed"
fi