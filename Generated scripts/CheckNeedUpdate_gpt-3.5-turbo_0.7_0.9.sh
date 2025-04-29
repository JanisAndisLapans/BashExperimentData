#!/bin/bash

if apt list --upgradable 2>/dev/null | grep -q "\bhtop\b"; then
    echo "update needed"
else
    echo "update not needed"
fi