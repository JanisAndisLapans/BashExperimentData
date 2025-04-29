#!/bin/bash

while [ $# -gt 0 ]; do
    case $1 in
        --sc) COPY=true; shift;;
        --sd) DELETE=true; shift;;
        --dr) REPLACE=true; shift;;
        --dk) KEEP=true; shift;;
        --dd) DELETE_DEST=true; shift;;
        --sw) SWAP=true; shift;;
        *) break;;
    esac
done

SOURCE=$1
DESTINATION=$2

if [ -z "$SOURCE" ] || [ -z "$DESTINATION" ]; then
    echo "Error: Source and destination directories are required."
    exit 1
fi

if [ "$SWAP" = true ]; then
    for file in "$SOURCE"/*; do
        if [ -f "$file" ]; then
            mv "$file" "$DESTINATION"
        elif [ -d "$file" ]; then
            mv "$file" "$DESTINATION"
        fi
    done
    for file in "$DESTINATION"/*; do
        if [ -f "$file" ]; then
            mv "$file" "$SOURCE"
        elif [ -d "$file" ]; then
            mv "$file" "$SOURCE"
        fi
    done
    exit 0
fi

if [ "$DELETE_DEST" = true ]; then
    rm -rf "$DESTINATION"/*
fi

for file in "$SOURCE"/*; do
    if [ -f "$file" ]; then
        if [ "$COPY" = true ]; then
            if [ -f "$DESTINATION/$(basename "$file")" ]; then
                if [ "$REPLACE" = true ]; then
                    cp -f "$file" "$DESTINATION"
                elif [ "$KEEP" = true ]; then
                    continue
                fi
            else
                cp "$file" "$DESTINATION"
            fi
        else
            if [ -f "$DESTINATION/$(basename "$file")" ]; then
                if [ "$REPLACE" = true ]; then
                    mv -f "$file" "$DESTINATION"
                elif [ "$KEEP" = true ]; then
                    continue
                fi
            else
                mv "$file" "$DESTINATION"
            fi
        fi
    elif [ -d "$file" ]; then
        if [ "$COPY" = true ]; then
            if [ -d "$DESTINATION/$(basename "$file")" ]; then
                if [ "$REPLACE" = true ]; then
                    cp -rf "$file" "$DESTINATION"
                elif [ "$KEEP" = true ]; then
                    continue
                fi
            else
                cp -r "$file" "$DESTINATION"
            fi
        else
            if [ -d "$DESTINATION/$(basename "$file")" ]; then
                if [ "$REPLACE" = true ]; then
                    mv -f "$file" "$DESTINATION"
                elif [ "$KEEP" = true ]; then
                    continue
                fi
            else
                mv "$file" "$DESTINATION"
            fi
        fi
    fi
done

if [ "$DELETE" = true ]; then
    rm -rf "$SOURCE"/*
fi