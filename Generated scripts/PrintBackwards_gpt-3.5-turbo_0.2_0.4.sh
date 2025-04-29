#!/bin/bash

while IFS= read -r line; do
    echo "result = $(rev <<< "$line")"
done < info.txt