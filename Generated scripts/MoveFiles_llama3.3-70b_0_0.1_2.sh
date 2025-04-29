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

SOURCE=${1:?}
DESTINATION=${2:?}

if [ ! -d "$SOURCE" ] || [ ! -d "$DESTINATION" ]; then
  echo "Source and destination must be directories"
  exit 1
fi

if [ "$SWAP" = true ]; then
  for file in "$SOURCE"/*; do
    [ -e "$file" ] || continue
    mv "$file" "$DESTINATION"
  done
  for file in "$DESTINATION"/*; do
    [ -e "$file" ] || continue
    mv "$file" "$SOURCE"
  done
  exit 0
fi

if [ "$DELETE_DEST" = true ]; then
  rm -rf "$DESTINATION"/*
fi

for file in "$SOURCE"/*; do
  [ -e "$file" ] || continue
  filename=$(basename "$file")
  dest_file="$DESTINATION/$filename"
  if [ -f "$dest_file" ]; then
    if [ -z "$REPLACE" ] && [ -z "$KEEP" ]; then
      rm -f "$dest_file"
      if [ "$COPY" = true ] || [ -z "$COPY" ]; then
        cp -p "$file" "$dest_file"
      else
        mv "$file" "$dest_file"
      fi
    elif [ "$REPLACE" = true ]; then
      if [ "$COPY" = true ]; then
        cp -p "$file" "$dest_file"
      else
        mv "$file" "$dest_file"
      fi
    elif [ "$KEEP" = true ]; then
      if [ "$COPY" = true ]; then
        filename=$(basename "$file")
        filename="${filename%.*}_copy${filename##*.}"
        cp -p "$file" "$DESTINATION/$filename"
      fi
    fi
  else
    if [ "$COPY" = true ] || [ -z "$COPY" ]; then
      cp -p "$file" "$DESTINATION"
    else
      mv "$file" "$DESTINATION"
    fi
  fi
done

if [ "$DELETE" = true ]; then
  rm -rf "$SOURCE"/*
fi