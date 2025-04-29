if [ "$(apt-get -s upgrade htop 2>/dev/null | grep -oP '^Inst \K[^ ]+')" == "htop" ]; then
    echo "update needed"
else
    echo "update not needed"
fi