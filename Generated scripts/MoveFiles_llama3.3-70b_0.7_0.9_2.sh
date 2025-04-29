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

if [ "$COPY" = true ]; then
  if [ "$REPLACE" = true ]; then
    cp -rf "${SOURCE}/"*. "${DESTINATION}/"
  elif [ "$KEEP" = true ]; then
    cp -nrf "${SOURCE}/"*. "${DESTINATION}/"
  else
    cp -rf "${SOURCE}/"*. "${DESTINATION}/"
  fi
elif [ "$SWAP" = true ]; then
  tmp_dir=$(mktemp -d)
  mv "${SOURCE}"/* "${tmp_dir}/"
  mv "${DESTINATION}"/* "${SOURCE}/"
  mv "${tmp_dir}"/* "${DESTINATION}/"
  rm -rf "${tmp_dir}"
else
  mv "${SOURCE}"/* "${DESTINATION}/"
fi

if [ "$DELETE" = true ]; then
  rm -rf "${SOURCE}"/*
fi

if [ "$DELETE_DEST" = true ]; then
  rm -rf "${DESTINATION}"/*
  mkdir -p "${DESTINATION}"
  cp -rf "${SOURCE}"/* "${DESTINATION}/"
fi