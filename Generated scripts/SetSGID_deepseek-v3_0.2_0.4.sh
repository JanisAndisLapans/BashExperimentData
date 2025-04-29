#!/bin/bash
if [ -d "$1/.sn" ]; then
    find "$1/.sn" -type d -exec chmod g+s {} \;
fi