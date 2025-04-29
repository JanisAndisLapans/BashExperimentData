#!/bin/bash

source_dir="$1"
destination_dir="$2"
shift 2

copy_from_source=true
delete_from_source=false
replace_in_destination=true
delete_existing_in_destination=false
swap_contents=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --sc) copy_from_source=true ;;
    --sd) delete_from_source=true ;;
    --dr) replace_in_destination=true ;;
    --dk) replace_in_destination=false ;;
    --dd) delete_existing_in_destination=true ;;
    --sw) swap_contents=true ;;
    *) echo "Unknown option: $1" ;;
  esac
  shift
done

if $swap_contents; then
  temp_dir=$(mktemp -d)
  mv "${source_dir:?}/"* "$temp_dir"
  mv "${destination_dir:?}/"* "$source_dir"
  mv "${temp_dir:?}/"* "$destination_dir"
  rmdir "$temp_dir"
else
  if $delete_existing_in_destination; then
    rm -rf "${destination_dir:?}/"*
  fi

  if $copy_from_source; then
    if $replace_in_destination; then
      cp -r "${source_dir:?}/"* "$destination_dir"
    else
      cp -rn "${source_dir:?}/"* "$destination_dir"
    fi
  fi

  if $delete_from_source; then
    rm -rf "${source_dir:?}/"*
  fi
fi