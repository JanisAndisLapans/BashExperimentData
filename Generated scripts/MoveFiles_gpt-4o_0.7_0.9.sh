#!/bin/bash

SOURCE=$1
DESTINATION=$2
shift 2

COPY=true
DELETE_SOURCE=false
REPLACE_DESTINATION=true
DELETE_DESTINATION=false
SWAP=false

for arg in "$@"; do
  case $arg in
    --sc)
      COPY=true
      ;;
    --sd)
      DELETE_SOURCE=true
      ;;
    --dr)
      REPLACE_DESTINATION=true
      ;;
    --dk)
      REPLACE_DESTINATION=false
      ;;
    --dd)
      DELETE_DESTINATION=true
      ;;
    --sw)
      SWAP=true
      ;;
  esac
done

if $SWAP; then
  TMP_DIR=$(mktemp -d)
  mv "$SOURCE"/* "$TMP_DIR"/
  mv "$DESTINATION"/* "$SOURCE"/
  mv "$TMP_DIR"/* "$DESTINATION"/
  rm -r "$TMP_DIR"
else
  if $DELETE_DESTINATION; then
    rm -rf "$DESTINATION"/*
  fi

  if $COPY; then
    if $REPLACE_DESTINATION; then
      cp -r "$SOURCE"/* "$DESTINATION"/
    else
      cp -rn "$SOURCE"/* "$DESTINATION"/
    fi
  fi

  if $DELETE_SOURCE; then
    rm -rf "$SOURCE"/*
  fi
fi