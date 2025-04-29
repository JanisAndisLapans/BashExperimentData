#!/bin/bash

SOURCE="${1}"
DESTINATION="${2}"
shift 2

COPY_FROM_SOURCE=true
DELETE_FROM_SOURCE=false
REPLACE_IN_DESTINATION=true
KEEP_IN_DESTINATION=false
DELETE_ALL_IN_DESTINATION=false
SWAP_CONTENTS=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --sc) COPY_FROM_SOURCE=true ;;
        --sd) DELETE_FROM_SOURCE=true ;;
        --dr) REPLACE_IN_DESTINATION=true ;;
        --dk) KEEP_IN_DESTINATION=true ;;
        --dd) DELETE_ALL_IN_DESTINATION=true ;;
        --sw) SWAP_CONTENTS=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if $SWAP_CONTENTS; then
    rsync -a --delete "$SOURCE/" "$DESTINATION.tmp/"
    rsync -a --delete "$DESTINATION/" "$SOURCE/"
    rsync -a --delete "$DESTINATION.tmp/" "$DESTINATION/"
    rm -rf "$DESTINATION.tmp/"
else
    if $DELETE_ALL_IN_DESTINATION; then
        rm -rf "$DESTINATION"/*
    fi

    if $COPY_FROM_SOURCE; then
        if $REPLACE_IN_DESTINATION; then
            rsync -a --delete "$SOURCE/" "$DESTINATION/"
        elif $KEEP_IN_DESTINATION; then
            rsync -a --ignore-existing "$SOURCE/" "$DESTINATION/"
        fi
    fi

    if $DELETE_FROM_SOURCE; then
        rm -rf "$SOURCE"/*
    fi
fi