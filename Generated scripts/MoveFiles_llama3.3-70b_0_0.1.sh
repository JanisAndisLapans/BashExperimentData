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
  echo "Source and destination directories must be provided"
  exit 1
fi

if [ ! -d "$SOURCE" ]; then
  echo "Source directory does not exist"
  exit 1
fi

if [ ! -d "$DESTINATION" ]; then
  echo "Destination directory does not exist"
  exit 1
fi

if [ "$SWAP" = true ]; then
  for file in "$SOURCE"/*; do
    mv "$file" "$DESTINATION"
  done
  for file in "$DESTINATION"/*; do
    mv "$file" "$SOURCE"
  done
  exit 0
fi

if [ "$DELETE_DEST" = true ]; then
  rm -rf "$DESTINATION"/*
fi

for file in "$SOURCE"/*; do
  filename=$(basename "$file")
  dest_file="$DESTINATION/$filename"
  if [ -f "$dest_file" ]; then
    if [ "$REPLACE" = true ]; then
      cp -f "$file" "$dest_file"
    elif [ "$KEEP" = true ]; then
      continue
    fi
  else
    cp "$file" "$DESTINATION"
  fi
done

if [ "$DELETE" = true ]; then
  rm -rf "$SOURCE"/*
fi