#!/bin/bash

source_dir="$1"
dest_dir="$2"
shift 2

copy_from_source=true
delete_from_source=false
replace_same_name=true
delete_existing_in_dest=false
swap_contents=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --sc)
      copy_from_source=true
      ;;
    --sd)
      delete_from_source=true
      ;;
    --dr)
      replace_same_name=true
      ;;
    --dk)
      replace_same_name=false
      ;;
    --dd)
      delete_existing_in_dest=true
      ;;
    --sw)
      swap_contents=true
      ;;
    *)
      echo "Invalid option: $1"
      exit 1
      ;;
  esac
  shift
done

if $swap_contents; then
  temp_dir=$(mktemp -d)
  mv "${source_dir:?}"/* "$temp_dir/"
  mv "${dest_dir:?}"/* "$source_dir/"
  mv "$temp_dir"/* "$dest_dir/"
  rmdir "$temp_dir"
else
  if $delete_existing_in_dest; then
    rm -rf "${dest_dir:?}"/*
  fi

  if $copy_from_source; then
    if $replace_same_name; then
      cp -r "${source_dir:?}/." "${dest_dir:?}/"
    else
      rsync -av --ignore-existing "${source_dir:?}/" "${dest_dir:?}/"
    fi
  fi

  if $delete_from_source; then
    rm -rf "${source_dir:?}"/*
  fi
fi