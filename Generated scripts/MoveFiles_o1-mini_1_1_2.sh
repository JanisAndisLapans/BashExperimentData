#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [--sc] [--sd] [--dr | --dk | --dd] [--sw] source_dir destination_dir"
    exit 1
}

# Initialize flags
COPY_SOURCE=false
DELETE_SOURCE=false
REPLACE_DEST=false
KEEP_DEST=false
DELETE_DEST=false
SWAP=false

# Parse flags
while [[ "$1" == --* ]]; do
    case "$1" in
        --sc)
            COPY_SOURCE=true
            ;;
        --sd)
            DELETE_SOURCE=true
            ;;
        --dr)
            REPLACE_DEST=true
            ;;
        --dk)
            KEEP_DEST=true
            ;;
        --dd)
            DELETE_DEST=true
            ;;
        --sw)
            SWAP=true
            ;;
        *)
            echo "Unknown flag: $1"
            usage
            ;;
    esac
    shift
done

# Check for source and destination directories
if [ "$#" -ne 2 ]; then
    usage
fi

SOURCE="${1:?}"
DESTINATION="${2:?}"

# Validate source and destination directories
if [ ! -d "${SOURCE}" ]; then
    echo "Source directory does not exist."
    exit 1
fi

if [ ! -d "${DESTINATION}" ]; then
    echo "Destination directory does not exist."
    exit 1
fi

if [ "$SWAP" = true ]; then
    TEMP_DIR=$(mktemp -d)
    rsync -a --delete "${SOURCE}/" "${TEMP_DIR}/"
    rsync -a --delete "${DESTINATION}/" "${SOURCE}/"
    rsync -a --delete "${TEMP_DIR}/" "${DESTINATION}/"
    rm -rf "${TEMP_DIR}"
    exit 0
fi

if [ "$DELETE_DEST" = true ]; then
    rm -rf "${DESTINATION:?}/"*
fi

RSYNC_OPTS="-a"

if [ "$KEEP_DEST" = true ]; then
    RSYNC_OPTS+=" --ignore-existing"
fi

rsync $RSYNC_OPTS "${SOURCE}/" "${DESTINATION}/"

if [ "$DELETE_SOURCE" = true ]; then
    rm -rf "${SOURCE:?}/"*
fi