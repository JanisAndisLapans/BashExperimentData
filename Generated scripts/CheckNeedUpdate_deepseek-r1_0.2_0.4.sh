#!/bin/bash
if apt list --upgradable 2>/dev/null | grep -q "^htop/"; then
    echo "update needed"
else
    echo "update not needed"
fi