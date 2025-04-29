#!/bin/bash

SOURCE="${1:?}"
DEST="${2:?}"
shift 2

COPY_FROM_SOURCE=true
DELETE_FROM_SOURCE=false
REPLACE_IN_DEST=false
KEEP_IN_DEST=false
DELETE_ALL_IN_DEST=false
SWAP_CONTENTS=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --sc) COPY_FROM_SOURCE=true ;;
        --sd) DELETE_FROM_SOURCE=true ;;
        --dr) REPLACE_IN_DEST=true ;;
        --dk) KEEP_IN_DEST=true ;;
        --dd) DELETE_ALL_IN_DEST=true ;;
        --sw) SWAP_CONTENTS=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if $SWAP_CONTENTS; then
    rsync -a --delete "${SOURCE}/" "${DEST}.tmp/"
    rsync -a --delete "${DEST}/" "${SOURCE}/"
    rsync -a --delete "${DEST}.tmp/" "${DEST}/"
    rm -rf "${DEST}.tmp/"
    exit 0
fi

if $DELETE_ALL_IN_DEST; then
    rm -rf "${DEST}"/*
fi

if $COPY_FROM_SOURCE; then
    if $REPLACE_IN_DEST; then
        cp -rf "${SOURCE}/"* "${DEST}/"
    elif $KEEP_IN_DEST; then
        cp -r --no-clobber "${SOURCE}/"* "${DEST}/"
    fi
fi

if $DELETE_FROM_SOURCE; then
    rm -rf "${SOURCE}"/*
fi