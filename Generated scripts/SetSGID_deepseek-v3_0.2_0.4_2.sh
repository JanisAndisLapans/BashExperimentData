#!/bin/bash
if [ -d "$1/.sn" ]; then
    find "$1/.sn" -mindepth 1 -type d -exec chmod g+s {} \;
fi