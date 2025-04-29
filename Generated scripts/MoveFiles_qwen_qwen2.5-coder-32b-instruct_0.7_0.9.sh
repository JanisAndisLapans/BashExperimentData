#!/bin/bash

SOURCE="$1"
DESTINATION="$2"
shift 2

COPY_FROM_SOURCE=true
DELETE_FROM_SOURCE=false
REPLACE_IN_DEST=true
KEEP_IN_DEST=false
DELETE_ALL_IN_DEST=false
SWAP=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --sc) COPY_FROM_SOURCE=true ;;
        --sd) DELETE_FROM_SOURCE=true ;;
        --dr) REPLACE_IN_DEST=true ;;
        --dk) KEEP_IN_DEST=true ;;
        --dd) DELETE_ALL_IN_DEST=true ;;
        --sw) SWAP=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if $SWAP; then
    rsync -a --delete "$SOURCE/" "$DESTINATION.tmp/"
    rsync -a --delete "$DESTINATION/" "$SOURCE/"
    rsync -a --delete "$DESTINATION.tmp/" "$DESTINATION/"
    rm -rf "$DESTINATION.tmp"
else
    if $DELETE_ALL_IN_DEST; then
        rm -rf "$DESTINATION"/*
    fi

    if $COPY_FROM_SOURCE; then
        if $REPLACE_IN_DEST; then
            rsync -a --delete "$SOURCE/" "$DESTINATION/"
        elif $KEEP_IN_DEST; then
            rsync -a --ignore-existing "$SOURCE/" "$DESTINATION/"
        fi
    fi

    if $DELETE_FROM_SOURCE; then
        rm -rf "$SOURCE"/*
    fi
fi