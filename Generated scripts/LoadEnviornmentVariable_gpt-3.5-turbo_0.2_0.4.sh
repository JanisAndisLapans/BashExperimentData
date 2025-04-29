#!/bin/bash

# Load the value of "USERNAME" from the .env file in the current directory
if [ -f .env ]; then
    source .env
    echo $USERNAME
else
    echo "Error: .env file not found"
fi