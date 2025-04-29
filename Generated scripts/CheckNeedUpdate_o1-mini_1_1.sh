if apt list --upgradable 2>/dev/null | grep -E "^htop/" > /dev/null; then
    echo "update needed"
else
    echo "update not needed"
fi