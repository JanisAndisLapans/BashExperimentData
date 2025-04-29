#!/bin/bash

factorial() {
    local n=$1
    if (( n <= 1 )); then
        echo 1
    else
        echo $(( n * $(factorial $((n - 1))) ))
    fi
}

factorial 623