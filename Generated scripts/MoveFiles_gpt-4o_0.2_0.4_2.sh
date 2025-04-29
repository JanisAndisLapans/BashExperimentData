#!/bin/bash

source_dir="$1"
destination_dir="$2"
shift 2

copy=true
delete_source=false
replace_dest=true
delete_dest=false
swap=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --sc) copy=true ;;
    --sd) delete_source=true ;;
    --dr) replace_dest=true ;;
    --dk) replace_dest=false ;;
    --dd) delete_dest=true ;;
    --sw) swap=true ;;
    *) echo "Unknown option: $1" ;;
  esac
  shift
done

if $swap; then
  temp_dir=$(mktemp -d)
  mv "${source_dir:?}/"* "$temp_dir"
  mv "${destination_dir:?}/"* "$source_dir"
  mv "${temp_dir:?}/"* "$destination_dir"
  rmdir "$temp_dir"
else
  if $delete_dest; then
    rm -rf "${destination_dir:?}/"*
  fi

  if $copy; then
    if $replace_dest; then
      cp -r "${source_dir:?}/"* "$destination_dir"
    else
      cp -rn "${source_dir:?}/"* "$destination_dir"
    fi
  fi

  if $delete_source; then
    rm -rf "${source_dir:?}/"*
  fi
fi