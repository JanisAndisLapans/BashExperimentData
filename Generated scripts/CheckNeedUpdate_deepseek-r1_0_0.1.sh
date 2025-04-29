apt-get update >/dev/null 2>&1
if apt list --upgradable 2>/dev/null | grep -qE '^htop/'; then
    echo "update needed"
else
    echo "update not needed"
fi