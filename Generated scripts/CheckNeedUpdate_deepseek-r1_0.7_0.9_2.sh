apt-get update >/dev/null 2>&1 && \
if apt list --upgradable --no-color 2>/dev/null | grep -q '^htop/'; then
    echo "update needed"
else
    echo "update not needed"
fi